//
//  TranslatedTextView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TranslatedTextOutputView: UIView {
    let disposeBag = DisposeBag()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        label.text = Language.en.title
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var translatedLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TranslatedTextOutputViewModel) {
        viewModel.translatedText
            .map {
                $0.isEmpty
            }
            .bind(to: self.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.selectedLanguage
            .map {
                $0.title
            }
            .bind(to: languageLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.translatedText
            .bind(onNext: { [weak self] text in
                self?.translatedLabel.rx.text
                    .onNext(text)
                self?.translatedLabel.setNeedsLayout()
            })
            .disposed(by: disposeBag)
        
        copyButton.rx.tap
            .bind(to: viewModel.copyButtonTap)
            .disposed(by: disposeBag)
        
        bookmarkButton.rx.tap
            .bind(to: viewModel.bookmarkButtonTap)
            .disposed(by: disposeBag)
        
        viewModel.isHiddenView
            .bind(to: self.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.copyButtonTap
            .withLatestFrom(viewModel.translatedText)
            .map {
                $0
            }
            .bind(onNext: {
                UIPasteboard.general.string = $0
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.isHidden = true
    }
    
    private func layout() {
        
        self.clipsToBounds = true
        
        [
            languageLabel,
            bookmarkButton,
            copyButton,
            translatedLabel
        ].forEach {
            self.addSubview($0)
        }
        
        languageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.bottom.equalTo(languageLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(languageLabel.snp.height)
        }
        
        copyButton.snp.makeConstraints {
            $0.top.bottom.equalTo(languageLabel)
            $0.trailing.equalTo(bookmarkButton.snp.leading).offset(-8)
            $0.width.height.equalTo(languageLabel.snp.height)
        }
        
        translatedLabel.snp.makeConstraints {
            $0.top.equalTo(languageLabel.snp.bottom).offset(8)
//            $0.leading.equalToSuperview().inset(20)
            $0.leading.equalTo(languageLabel)
            $0.trailing.equalTo(bookmarkButton)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

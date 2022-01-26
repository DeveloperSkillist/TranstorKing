//
//  SourceTextInputView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class SourceTextInputView: UIView {
    let disposeBag = DisposeBag()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        label.text = Language.ko.title
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemGray
        button.isHidden = true
        return button
    }()
    
    private lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.font = .systemFont(ofSize: 20)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SourceTextInputViewModel) {
        //selected
        viewModel.selectedLanguage
            .map {
                $0.title
            }
            .bind(to: languageLabel.rx.text)
            .disposed(by: disposeBag)
        
        //clearButton
        clearButton.rx.tap
            .bind(to: viewModel.clearButtonTap)
            .disposed(by: disposeBag)
        
        viewModel.inputText
            .map {
                return $0.isEmpty
            }
            .bind(to: clearButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.clearButtonTap
            .map {
                ""
            }
            .bind(to: inputTextView.rx.text)
            .disposed(by: disposeBag)
        
        //inputTextView
        inputTextView.rx.text
            .map {
                $0 ?? ""
            }
            .distinctUntilChanged()
            .bind(to: viewModel.inputText)
            .disposed(by: disposeBag)
        
        inputTextView.rx.didEndEditing
            .asObservable()
            .bind(to: viewModel.translateButtonTap)
            .disposed(by: disposeBag)
        
        inputTextView.rx.didChange
            .asObservable()
            .bind(to: viewModel.changedInputText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .systemBackground
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    private func layout() {
        
        self.clipsToBounds = true
        
        [
            languageLabel,
            clearButton,
            inputTextView
        ].forEach {
            self.addSubview($0)
        }
        
        languageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        clearButton.snp.makeConstraints {
            $0.top.bottom.equalTo(languageLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(languageLabel.snp.height)
        }
        
        inputTextView.snp.makeConstraints {
            $0.top.equalTo(languageLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(clearButton)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
}

extension SourceTextInputView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let isEnterKey = (text == "\n")
        if isEnterKey {
            endEditing(true)
        }
        return true
    }
}

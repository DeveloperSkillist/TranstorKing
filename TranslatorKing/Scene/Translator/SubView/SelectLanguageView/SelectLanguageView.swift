//
//  SelectLanguageView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import SnapKit
import RxSwift

class SelectLanguageView: UIView {
    let disposeBag = DisposeBag()
    
    private lazy var sourceLanguageButton: UIButton = {
        var button = UIButton()
        button.setTitle(Language.ko.title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var changeLanguageButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.tintColor = .label
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        var button = UIButton()
        button.setTitle(Language.en.title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        [
            sourceLanguageButton,
            changeLanguageButton,
            targetLanguageButton
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SelectLanguageViewModel) {
        viewModel.sourceLanguage
            .map {
                $0.title
            }
            .drive(sourceLanguageButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.targetLanguage
            .map {
                $0.title
            }
            .drive(targetLanguageButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        sourceLanguageButton.rx.tap
            .bind(to: viewModel.sourceLanguageButtonTap)
            .disposed(by: disposeBag)
        
        targetLanguageButton.rx.tap
            .bind(to: viewModel.targetLanguageButtonTap)
            .disposed(by: disposeBag)
        
        changeLanguageButton.rx.tap
            .bind(to: viewModel.changeLanguageButtonTap)
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}

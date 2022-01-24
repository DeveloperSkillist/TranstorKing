//
//  SourceTextInputView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import SnapKit

class SourceTextInputView: UIView {
    
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
        return button
    }()
    
    private lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.font = .systemFont(ofSize: 20)
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

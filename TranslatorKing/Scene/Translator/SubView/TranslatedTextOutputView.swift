//
//  TranslatedTextView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import SnapKit

class TranslatedTextOutputView: UIView {
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        label.text = Language.ko.title
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var resultLabel: UILabel = {
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
    
    private func attribute() {
        self.backgroundColor = .systemBackground
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    private func layout() {
        
        self.clipsToBounds = true
        
        [
            languageLabel,
            bookmarkButton,
            copyButton,
            resultLabel
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
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(languageLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(bookmarkButton)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

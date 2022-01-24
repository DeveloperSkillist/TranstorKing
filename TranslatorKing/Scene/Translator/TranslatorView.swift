//
//  TranslatorView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TranslatorView: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var selectLanguageView: SelectLanguageView = {
        let selectLanguageView = SelectLanguageView()
        return selectLanguageView
    }()
    
    private lazy var sourceTextInputView: SourceTextInputView = {
        let sourceTextInputView = SourceTextInputView()
        return sourceTextInputView
    }()
    
    private lazy var translatedTextOutputView: TranslatedTextOutputView = {
        let translatedTextOutputView = TranslatedTextOutputView()
        return translatedTextOutputView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        [
            selectLanguageView,
            sourceTextInputView,
            translatedTextOutputView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: TranslatorViewModel) {
        
    }
    
    private func attribute() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "translator_title".localize
    }
    
    private func layout() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [
            stackView
        ].forEach {
            scrollView.addSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }
}

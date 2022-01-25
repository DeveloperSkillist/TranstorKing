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
    let disposeBag = DisposeBag()
    
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
        //selectLanguageView
        selectLanguageView.bind(viewModel.selectLanguageViewModel)
        
        viewModel.selectLanguageViewModel.sourceLanguageButtonTap
            .flatMapFirst { _ in
                self.presentSelectLanguageAlert()
                    .map { $0 }
            }
            .bind(to: viewModel.selectLanguageViewModel.changedSourceLanguage)
            .disposed(by: disposeBag)
        
        viewModel.selectLanguageViewModel.targetLanguageButtonTap
            .flatMapFirst { _ in
                self.presentSelectLanguageAlert()
                    .map { $0 }
            }
            .bind(to: viewModel.selectLanguageViewModel.changedTargetLanguage)
            .disposed(by: disposeBag)
        
        viewModel.selectLanguageViewModel.sourceLanguage
            .asObservable()
            .map {
                $0
            }
            .bind(to: viewModel.sourceTextInputViewModel.selectedLanguage)
            .disposed(by: disposeBag)
        
        viewModel.selectLanguageViewModel.targetLanguage
            .asObservable()
            .map {
                $0
            }
            .bind(to: viewModel.translatedTextOutputViewModel.selectedLanguage)
            .disposed(by: disposeBag)
        
        let inputDatas = Observable.combineLatest(
            viewModel.selectLanguageViewModel.sourceLanguage
                .asObservable(),
            viewModel.selectLanguageViewModel.targetLanguage
                .asObservable(),
            viewModel.sourceTextInputViewModel.inputText
        )
        
        let settedTranslateRequestModel = viewModel.sourceTextInputViewModel.translateButtonTap
            .withLatestFrom(inputDatas) { ($1.0, $1.1, $1.2) }
            .map { sourceLan, targetLan, text -> TranslateRequestModel in
                return TranslateRequestModel(source: sourceLan.rawValue, target: targetLan.rawValue, text: text)
            }
        
        settedTranslateRequestModel
            .subscribe(onNext: {
                TranslateAPI().requestTranslate(translateRequestModel: $0) { trannslatedText in
                    viewModel.translatedTextOutputViewModel.translatedText
                        .accept(trannslatedText)
                }
            })
            .disposed(by: disposeBag)
        
        //sourceTextInputView
        sourceTextInputView.bind(viewModel.sourceTextInputViewModel)
        
        //translatedTextOutputView
        translatedTextOutputView.bind(viewModel.translatedTextOutputViewModel)
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
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    private func presentSelectLanguageAlert() -> Observable<Language> {
        let selectedLanguage = PublishSubject<Language>()
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let koAction = UIAlertAction(title: "Korean".localize, style: .default) { _ in
            selectedLanguage.onNext(.ko)
            selectedLanguage.onCompleted()
        }
        alertController.addAction(koAction)
        
        let enAction = UIAlertAction(title: "English".localize, style: .default) { _ in
            selectedLanguage.onNext(.en)
            selectedLanguage.onCompleted()
            }
        alertController.addAction(enAction)
        
        let jpAction = UIAlertAction(title: "Japanese".localize, style: .default) { _ in
            selectedLanguage.onNext(.ja)
            selectedLanguage.onCompleted()
        }
        alertController.addAction(jpAction)
        
        let chAction = UIAlertAction(title: "Chinese".localize, style: .default) { _ in
            selectedLanguage.onNext(.ch)
            selectedLanguage.onCompleted()
        }
        alertController.addAction(chAction)
        
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel) { _ in
            selectedLanguage.onCompleted()
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        return selectedLanguage
    }
}

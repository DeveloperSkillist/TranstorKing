//
//  TranslatedTextOutputViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import RxCocoa
import RxSwift

struct TranslatedTextOutputViewModel {
    let disposeBag = DisposeBag()
    
    //view -> viewModel
    let selectedLanguage = PublishRelay<Language>()
    let copyButtonTap = PublishRelay<Void>()
    let bookmarkButtonTap = PublishRelay<Void>()
    let translatedText = PublishRelay<String>()
    let isHiddenView = PublishRelay<Bool>()
    
    //viewModel -> view
    
    init() {
        copyButtonTap
            .withLatestFrom(translatedText) { $1 }
            .bind(onNext: {
                UIPasteboard.general.string = $0
            })
            .disposed(by: disposeBag)
    }
}

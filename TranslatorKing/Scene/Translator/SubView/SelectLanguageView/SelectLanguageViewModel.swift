//
//  SelectLanguageViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import Foundation
import RxCocoa
import RxSwift

struct SelectLanguageViewModel {
    let disposeBag = DisposeBag()
    
    //view -> viewModel
    var sourceLanguageButtonTap = PublishRelay<Void>()
    var targetLanguageButtonTap = PublishRelay<Void>()
    var changeLanguageButtonTap = PublishRelay<Void>()
    
    var changedSourceLanguage = PublishRelay<Language>()
    var changedTargetLanguage = PublishRelay<Language>()
    
    //viewModel -> view
    let sourceLanguage: Driver<Language>
    let targetLanguage: Driver<Language>
    
    init() {
        sourceLanguage = changedSourceLanguage
            .distinctUntilChanged()
            .startWith(.ko)
            .asDriver(onErrorJustReturn: .ko)
        
        targetLanguage = changedTargetLanguage
            .distinctUntilChanged()
            .startWith(.en)
            .asDriver(onErrorJustReturn: .en)
    }
}

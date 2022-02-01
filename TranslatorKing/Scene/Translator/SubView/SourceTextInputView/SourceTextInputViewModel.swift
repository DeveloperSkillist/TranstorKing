//
//  SourceTextInputViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import Foundation
import RxSwift
import RxCocoa

struct SourceTextInputViewModel {
    let disposeBag = DisposeBag()
    
    //view -> viewModel
    let clearButtonTap = PublishRelay<Void>()
    let inputText = PublishRelay<String>()
    let changedInputText = PublishRelay<Void>()
    let translateButtonTap = PublishSubject<Void>()
    
    //viewModel -> view
    let selectedLanguage = PublishRelay<Language>()
}

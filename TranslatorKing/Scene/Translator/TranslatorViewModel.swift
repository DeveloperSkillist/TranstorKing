//
//  TranslatorViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import RxCocoa
import RxSwift

struct TranslatorViewModel {
    let selectLanguageViewModel = SelectLanguageViewModel()
    let translatedTextOutputViewModel = TranslatedTextOutputViewModel()
    let sourceTextInputViewModel = SourceTextInputViewModel()
    
    //view -> viewModel
    
    init() {
    }
}

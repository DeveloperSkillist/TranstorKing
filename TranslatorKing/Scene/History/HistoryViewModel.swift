//
//  HistoryViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import RxSwift
import RxCocoa

struct HistoryViewModel {
    let disposeBag = DisposeBag()
    //view -> viewModel
    let viewWillAppear = PublishRelay<Void>()
    
    //viewModel -> view
    let cellData: Driver<[HistoryModel]>
    
    init() {
        cellData = viewWillAppear
            .map {
                UserDefaults.standard.history
            }
            .asDriver(onErrorJustReturn: [])
    }
}

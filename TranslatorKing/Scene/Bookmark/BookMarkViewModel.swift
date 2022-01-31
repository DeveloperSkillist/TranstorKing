//
//  BookMarkViewModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias BookmarkSectionModel = AnimatableSectionModel<Int, HistoryModel>

struct BookMarkViewModel {
    let disposeBag = DisposeBag()
//    lazy var bookMarkTableViewCellModel = BookMarkTableViewCellModel()
    
    //view -> viewModel
    let deleteBookmark = PublishRelay<HistoryModel>()
    
    //viewModel -> view
    let bookmarks = BehaviorRelay<[BookmarkSectionModel]>(value: [])
    let datasource: RxTableViewSectionedAnimatedDataSource<BookmarkSectionModel> = {
        let dataSource = RxTableViewSectionedAnimatedDataSource<BookmarkSectionModel>(configureCell: {
            (dataSource, tableView, indexPath, bookmark) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkTableViewCell.identify) as? BookMarkTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
//            cell.bind(bookMarkTableViewCellModel)
            cell.setup(bookmark: bookmark)
            return cell
        })
        
        dataSource.canEditRowAtIndexPath = { _, _ in
            return true
        }
        return dataSource
    }()
    
    init() {
        UserDefaults.standard.rx.observe(Data.self, UserDefaults.standard.bookmarkKey)
            .map {
                guard let data = $0 else {
                    return []
                }
                
                return (try? PropertyListDecoder().decode([HistoryModel].self, from: data)) ?? []
            }
            .map {
                [BookmarkSectionModel(model: 0, items: $0)]
            }
            .debug()
            .bind(to: bookmarks)
            .disposed(by: disposeBag)
        
        deleteBookmark
            .subscribe(onNext: {
                UserDefaults.standard.deleteBookmark(historyModel: $0)
            })
            .disposed(by: disposeBag)
    }
}

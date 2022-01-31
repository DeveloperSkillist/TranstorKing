//
//  BookMarkView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BookMarkView: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: BookMarkViewModel?
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.register(BookMarkTableViewCell.self, forCellReuseIdentifier: BookMarkTableViewCell.identify)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: BookMarkViewModel) {
        self.viewModel = viewModel
        
        viewModel.bookmarks
            .debug()
            .bind(to: tableView.rx.items(dataSource: viewModel.datasource))
            .disposed(by: disposeBag)
        
//        Observable.merge(
//            tableView.rx.modelDeleted(HistoryModel.self)
//                .asObservable(),
//            viewModel.bookMarkTableViewCellModel.deleteButtonTapped
//        )
//            .bind(to: viewModel.deleteBookmark)
//            .disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(HistoryModel.self)
            .bind(to: viewModel.deleteBookmark)
            .disposed(by: disposeBag)
        
    }
    
    private func attribute() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "bookmark_title".localize
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

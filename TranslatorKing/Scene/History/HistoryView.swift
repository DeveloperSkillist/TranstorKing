//
//  HistoryView.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HistoryView: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: HistoryViewModel?
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identify)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.viewWillAppear
            .accept(())
    }
    
    func bind(_ viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        
        viewModel.cellData
            .drive(tableView.rx.items) {[weak self] tv, row, data in
                guard let cell = self?.tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identify) as? HistoryTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.setup(historyModel: data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "history_title".localize
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

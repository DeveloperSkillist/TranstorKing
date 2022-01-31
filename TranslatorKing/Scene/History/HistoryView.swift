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
    var viewModel: HistoryViewModel?    //viewModel입니다.
    
    //tableView
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
        
        //viewWillAppear에서 history를 새로고침
        self.viewModel?.viewWillAppear
            .accept(())
    }
    
    func bind(_ viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        
        //기본적인 cellData를 통해, tableView 구성
        viewModel.cellData
            .drive(tableView.rx.items) { tableView, row, data in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identify) as? HistoryTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none //selection 애니메이션 삭제
                cell.setup(historyModel: data)  //cell data 설정
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

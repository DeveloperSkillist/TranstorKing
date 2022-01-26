//
//  HistoryTableViewCell.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let identify = "HistoryTableViewCell"
    
    private var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .systemBackground
        uiView.layer.cornerRadius = 10
        uiView.clipsToBounds = true
        return uiView
    }()
    
    private var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        label.text = Language.ko.title
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var sourceTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        label.text = Language.en.title
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var translatedTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    private func layout() {
        
        addSubview(uiView)
        uiView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        [
            sourceLabel,
            sourceTextLabel,
            lineView,
            targetLabel,
            translatedTextLabel
        ].forEach {
            uiView.addSubview($0)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        sourceTextLabel.snp.makeConstraints {
            $0.top.equalTo(sourceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(sourceLabel)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(sourceTextLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        targetLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(sourceLabel)
        }
        
        translatedTextLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(sourceLabel)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setup(historyModel: HistoryModel) {
        sourceLabel.text = historyModel.sourceLanguage.title
        sourceTextLabel.text = historyModel.sourceText
        targetLabel.text = historyModel.targetLanguage.title
        translatedTextLabel.text = historyModel.targetText
    }
}

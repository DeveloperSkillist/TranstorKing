//
//  Language.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    case ko
    case en
    case ja
    case ch = "zh-CN"
    
    var title: String {
        switch self {
        case .ko:
            return "korean".localize
        case .en:
            return "english".localize
        case .ja:
            return "japanese".localize
        case .ch:
            return "chinese".localize
        }
    }
}

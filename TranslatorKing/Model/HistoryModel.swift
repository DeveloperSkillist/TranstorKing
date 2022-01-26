//
//  HistoryModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import Foundation

struct HistoryModel: Codable {
    let sourceLanguage: Language
    let targetLanguage: Language
    let sourceText: String
    let targetText: String
}

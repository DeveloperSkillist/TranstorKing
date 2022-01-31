//
//  HistoryModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import Foundation
import Differentiator

struct HistoryModel: Codable, Equatable, IdentifiableType {
    var identity: String {
        return sourceText + targetText
    }
    
    let sourceLanguage: Language
    let targetLanguage: Language
    let sourceText: String
    let targetText: String
}

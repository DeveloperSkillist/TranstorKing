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
    
    let sourceLanguage: Language    //번역할 언어
    let targetLanguage: Language    //번역된 언어
    let sourceText: String          //번역할 text
    let targetText: String          //번역된 text
}

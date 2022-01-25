//
//  TranslateAPIModel.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/25.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    var translatedText: String {
        return message.result.translatedText
    }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}

//
//  String+Extension.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import Foundation

extension String {
    var localize: String {
        NSLocalizedString(self, comment: self)
    }
}

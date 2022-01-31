//
//  UserDefault+Extension.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/26.
//

import Foundation

extension UserDefaults {
    
    var historyKey: String {
        return "history"
    }
    
    var history: [HistoryModel] {
        get {
            guard let data = UserDefaults.standard.data(forKey: historyKey) else {
                return []
            }
            
            return (try? PropertyListDecoder().decode([HistoryModel].self, from: data)) ?? []
        }
        set {
            var newHistorys = newValue
            if newHistorys.count > 10 {
                newHistorys.removeLast()
            }
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newHistorys), forKey: historyKey)
        }
    }
    
    var bookmarkKey: String {
        return "bookmark"
    }
    
    var bookmark: [HistoryModel] {
        get {
            guard let data = UserDefaults.standard.data(forKey: bookmarkKey) else {
                return []
            }
            
            return (try? PropertyListDecoder().decode([HistoryModel].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey: bookmarkKey)
        }
    }
    
    func deleteBookmark(historyModel: HistoryModel) {
        var bookmarks = UserDefaults.standard.bookmark
        if let index = bookmarks.firstIndex(of: historyModel) {
            bookmarks.remove(at: index)
            self.bookmark = bookmarks
        }
    }
}

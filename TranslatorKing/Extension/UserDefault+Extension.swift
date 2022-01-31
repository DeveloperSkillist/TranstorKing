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
    
    func addHistory(historyModel: HistoryModel) {
        var histories = UserDefaults.standard.history
        if let index = histories.firstIndex(of: historyModel) { //중복 제거 로직.
            histories.remove(at: index)
        }
        
        self.history = [historyModel] + histories
    }
}

extension UserDefaults {
    
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
    
    func addBookmark(historyModel: HistoryModel) {
        var bookmarks = UserDefaults.standard.bookmark
        if let index = bookmarks.firstIndex(of: historyModel) {
            bookmarks.remove(at: index)
        }
        
        self.bookmark = [historyModel] + bookmarks
    }
    
    func deleteBookmark(historyModel: HistoryModel) {
        var bookmarks = UserDefaults.standard.bookmark
        if let index = bookmarks.firstIndex(of: historyModel) {
            bookmarks.remove(at: index)
            self.bookmark = bookmarks
        }
    }
}

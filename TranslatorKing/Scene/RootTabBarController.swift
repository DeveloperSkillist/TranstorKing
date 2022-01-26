//
//  RootTabBarController.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/24.
//

import UIKit

class RootTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        setupTabBars()
    }
}

private extension RootTabController {
    func layout() {
        view.backgroundColor = .systemBackground
    }

    func setupTabBars() {
        let translatorView = TranslatorView()
        translatorView.bind(TranslatorViewModel())
        
        let translatorViewController = UINavigationController(rootViewController: translatorView)
        translatorViewController.tabBarItem = UITabBarItem(
            title: "translator_title".localize,
            image: UIImage(systemName: "doc.plaintext"),
            selectedImage: UIImage(systemName: "doc.plaintext.fill")
        )

        let historyView = HistoryView()
        historyView.bind(HistoryViewModel())
        
        let historyViewController = UINavigationController(rootViewController: historyView)
        historyViewController.tabBarItem = UITabBarItem(
            title: "history_title".localize,
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill")
        )

        let bookmarkView = BookMarkView()
        bookmarkView.bind(BookMarkViewModel())
        
        let bookmarkViewController = UINavigationController(rootViewController: bookmarkView)
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: "bookmark_title".localize,
            image: UIImage(systemName: "square.and.arrow.down"),
            selectedImage: UIImage(systemName: "square.and.arrow.down.fill")
        )

        viewControllers = [
            translatorViewController,
            historyViewController,
            bookmarkViewController
        ]
    }
}

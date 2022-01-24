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
        let translatorViewController = UINavigationController(rootViewController: TranslatorView())
        //TODO: translatorViewController.bind(translatorViewModel)
        translatorViewController.tabBarItem = UITabBarItem(
            title: "translator_title".localize,
            image: UIImage(systemName: "doc.plaintext"),
            selectedImage: UIImage(systemName: "doc.plaintext.fill")
        )

        let historyViewController = UIViewController()
        historyViewController.tabBarItem = UITabBarItem(
            title: "history_title".localize,
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill")
        )

        let bookmarkViewController = UIViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: "bookmark_title".localize,
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )

        viewControllers = [
            translatorViewController,
            historyViewController,
            bookmarkViewController
        ]
    }
}

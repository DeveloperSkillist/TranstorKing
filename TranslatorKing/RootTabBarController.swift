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

        view.backgroundColor = .systemBackground

        let translatorViewController = UIViewController()
        translatorViewController.tabBarItem = UITabBarItem(
            title: "번역",
            image: UIImage(systemName: "doc.plaintext"),
            selectedImage: UIImage(systemName: "doc.plaintext.fill")
        )

        let historyViewController = UIViewController()
        historyViewController.tabBarItem = UITabBarItem(
            title: "기록",
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill")
        )

        let bookmarkViewController = UIViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: "즐겨찾기",
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

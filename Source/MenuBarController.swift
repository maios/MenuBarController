//
//  MenuBarController.swift
//  MenuBarController
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import UIKit

open class MenuBarController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
    }

    // MARK: UI Setup

    public lazy var menuBar = MenuBar()
    private lazy var containerView = UIView()

    private func buildUI() {
        view.addSubview(menuBar)
        view.addSubview(containerView)

        menuBar.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 44),
            containerView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK:

    open var viewControllers: [UIViewController] = [] {
        didSet {
            reloadMenuBar()
        }
    }

    private func reloadMenuBar() {
        menuBar.reset()

        let items = viewControllers.map { $0.menuBarItem }
        menuBar.add(items: items)
    }

    // MARK:

}

extension UIViewController {

    private struct AssociatedKey {
        static var menuBarItem: UInt8 = 0
    }

    public var menuBarItem: MenuBarItem {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.menuBarItem) as? MenuBarItem ?? MenuBarItem(title: title)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.menuBarItem, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

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

        menuBar.delegate = self
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
        selectedIndex = 0
    }

    // MARK:

    open var selectedViewController: UIViewController {
        return viewControllers[selectedIndex]
    }

    private var _selectedIndex: Int = 0
    open var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        set {
            guard case 0 ..< viewControllers.count = newValue else {
                return
            }
            removeContentViewController()
            _selectedIndex = newValue
            show(contentViewController: viewControllers[newValue])
        }
    }

    private func removeContentViewController() {
        selectedViewController.willMove(toParentViewController: nil)
        selectedViewController.view.removeFromSuperview()
        selectedViewController.removeFromParentViewController()
    }

    private func show(contentViewController: UIViewController) {
        removeContentViewController()

        contentViewController.willMove(toParentViewController: self)
        containerView.addSubview(contentViewController.view)
        contentViewController.view.frame = containerView.bounds
        addChildViewController(contentViewController)
        contentViewController.didMove(toParentViewController: self)
    }
}

extension MenuBarController: MenuBarDelegate {

    public func menuBar(_ menuBar: MenuBar, didSelect item: MenuBarItem) {
        guard let newIndex = viewControllers.index(where: { $0.menuBarItem == item }) else {
            return
        }
        selectedIndex = newIndex
    }

}

extension UIViewController {

    private struct AssociatedKey {
        static var menuBarItem: UInt8 = 0
    }

    public var menuBarItem: MenuBarItem {
        get {
            var item: MenuBarItem! = objc_getAssociatedObject(self, &AssociatedKey.menuBarItem) as? MenuBarItem
            if item == nil {
                item = MenuBarItem(title: title)
                objc_setAssociatedObject(self, &AssociatedKey.menuBarItem, item, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return item
         }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.menuBarItem, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

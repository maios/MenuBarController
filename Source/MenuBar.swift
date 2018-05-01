//
//  MenuBar.swift
//  MenuBarController
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import UIKit

@objc
public protocol MenuBarDelegate {
    @objc optional func menuBar(_ menuBar: MenuBar, didSelect item: MenuBarItem)
}

open class MenuBar: UIView {

    open weak var delegate: MenuBarDelegate? = nil

    // MARK: Initializations

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI Setup

    private lazy var itemsStackView = with(UIStackView()) { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }

    private func buildUI() {
        addSubview(itemsStackView)

        itemsStackView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            itemsStackView.topAnchor.constraint(equalTo: topAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: Data populate

    open func reset() {
        for arrangedSubview in itemsStackView.arrangedSubviews {
            arrangedSubview.removeFromSuperview()
        }
    }

    open func add(item: MenuBarItem) {
        itemsStackView.addArrangedSubview(item.view)
        item.tapHandler = { item in
            self.delegate?.menuBar?(self, didSelect: item)
        }
    }

    open func add(items: [MenuBarItem]) {
        items.forEach(add(item:))
    }

}

//
//  MenuBar.swift
//  MenuBarController
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import UIKit

open class MenuBar: UIView {

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

    // MARK: Data population

    open func reset() {
        for arrangedSubview in itemsStackView.arrangedSubviews {
            arrangedSubview.removeFromSuperview()
        }
    }

    open func add(item: MenuBarItem) {
        itemsStackView.addArrangedSubview(item.view)
    }

    open func add(items: [MenuBarItem]) {
        items.forEach(add(item:))
    }

}

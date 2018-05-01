//
//  MenuBarItem.swift
//  MenuBarController
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import UIKit

open class MenuBarItem: NSObject {

    open let view: UIView

    public convenience init(title: String?) {
        let label = with(UILabel()) { label in
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkText
            label.textAlignment = .center

            label.text = title
        }
        self.init(customView: label)
    }

    public init(customView: UIView) {
        view = customView
    }

}

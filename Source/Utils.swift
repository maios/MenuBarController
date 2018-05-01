//
//  Utils.swift
//  MenuBarController
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import Foundation

@discardableResult
func with<T>(_ item: T, _ block: (T) -> Void) -> T {
    block(item)
    return item
}

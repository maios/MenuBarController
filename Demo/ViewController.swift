//
//  ViewController.swift
//  Demo
//
//  Created by Mai Mai on 5/1/18.
//  Copyright © 2018 maimaios. All rights reserved.
//

import UIKit
import MenuBarController

class ViewController: MenuBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let viewController1 = UIViewController()
        viewController1.title = "Item 1"
        viewController1.view.backgroundColor = .red

        let viewController2 = UIViewController()
        viewController2.title = "Item 2"
        viewController2.view.backgroundColor = .green

        let viewController3 = UIViewController()
        viewController3.title = "Item 3"
        viewController3.view.backgroundColor = .blue

        viewControllers = [viewController1, viewController2, viewController3]

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}


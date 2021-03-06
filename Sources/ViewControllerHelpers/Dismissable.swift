//
//  File.swift
//  
//
//  Created by Inal Gotov on 2020-04-03.
//

import UIKit

public protocol Dismissable {}

extension Dismissable where Self: UIViewController {
    public func dismiss() {
        if let navVC = self.navigationController {
            if navVC.viewControllers.count > 1 {
                navVC.popViewController(animated: true)
            }
            else {
                navVC.dismiss(animated: true)
            }
        }
        else {
            self.dismiss(animated: true)
        }
    }
}

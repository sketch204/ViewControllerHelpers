//
//  Presentable.swift
//
//
//  Created by Inal Gotov on 2020-04-03.
//

import UIKit

/**
Use this protocol for an easy way to instantiate and present your view controllers from their storyboards. Objects conforming to this protocol must provide a storyboardName property with an initial value.
*/
protocol Presentable: Storyboarded {}

extension Presentable where Self: UIViewController {
    
    @discardableResult
    static func present(in host: UIViewController,
                        presenter: Presenter,
                        configuration: ((Self) -> Void)? = nil) -> Bool
    {
        guard let vc = Self.instantiate() else { return false }
        configuration?(vc)
        presenter.present(viewController: vc, inside: host)
        return true
    }
}

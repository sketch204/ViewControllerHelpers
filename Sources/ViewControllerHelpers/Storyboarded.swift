//
//  Storyboarded.swift
//
//
//  Created by Inal Gotov on 2020-04-03.
//

import UIKit

/**
 Use this protocol for an easy way to instantiate your view controllers from their storyboards. Objects conforming to this protocol must provide a storyboardName property with an initial value.
 */
protocol Storyboarded {
    /// The default storyboard ID of for this view controller. By default this value is set to the class name of this view controller. For a view controller named `MyViewController`, by default this value will be synthesized to return `MyViewController`.
    static var storyboardID: String { get }
    /// The name of the storyboard that contains this view controller. No file extension.
    static var storyboardName: String { get }
}

extension Storyboarded where Self: UIViewController {
    static var storyboardID: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    /// Instantiates a new instance of this view controller.
    /// - Parameters:
    ///   - storyboardName: The Storyboard from which to instantiate this view controller. The default value is the static property of this view controller.
    ///   - storyboardId: The ID of this view controller inside the storyboard. The default value is the static property of this view controller.
    /// - Returns: Returns a new instance of this view controller, instantiated from its storyboard.
    static func instantiate(storyboardName: String = Self.storyboardName,
                            storyboardID: String = Self.storyboardID) -> Self?
    {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
            .instantiateViewController(withIdentifier: storyboardID) as? Self
    }
    
    /// Instantiates a new instance of this view controller wrapped inside a navigation controller.
    /// - Parameters:
    ///   - storyboardName: The Storyboard from which to instantiate this view controller. The default value is the static property of this view controller.
    ///   - storyboardId: The ID of this view controller inside the storyboard. The default value is the static property of this view controller.
    /// - Returns: Returns a UINavigationController containing a new instance of this view controller, instantiated from its storyboard, as its root controller.
    static func instantiateWithNavController(storyboardName: String = Self.storyboardName,
                                             storyboardID: String = Self.storyboardID) -> UINavigationController?
    {
        if let vc = Self.instantiate(storyboardName: storyboardName,
                                     storyboardID: storyboardID)
        {
            return UINavigationController(rootViewController: vc)
        }
        return nil
    }
}

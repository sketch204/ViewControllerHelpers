//
//  Presenter.swift
//  
//
//  Created by Inal Gotov on 2020-04-03.
//

import UIKit

/// This rotocol represents a presenter object. A presented obejct is responsible for presenting a given view controller, the presenter must show that view controller inside its given host view controller.
public protocol Presenter {
    /// Present the given view controller in the given host.
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - host: The host view controller, inside which the view controller should be presented.
    func present(viewController: UIViewController, inside host: UIViewController)
}

/// A presenter that handles presentation using UINavigationControllers.
///
/// By default if the given host view controller does not have a UINavigationController, then it falls back to a modal presentation style.
public struct NavigationStackPresenter: Presenter {
    /// When this is set to true, the presenter will attempt to clear the navigation stack of the navigation controller, making the presented view controller the only view controller in the navigation stack (removing the back button). The default value is false.
    public var clearNavigationStack = false
    /// When this is set to true, if the host view controller does not have a navigation controller, then a modal presentation is used instead. Else nothing happens. The default value is true.
    public var presentModallyIfNoViewController = true
    public var animated = true
    
    public func present(viewController: UIViewController, inside host: UIViewController) {
        if let navVC = host.navigationController {
            if clearNavigationStack {
                navVC.setViewControllers([viewController], animated: animated)
            }
            else {
                navVC.pushViewController(viewController, animated: animated)
            }
        }
        else {
            if presentModallyIfNoViewController {
                host.present(viewController, animated: animated, completion: nil)
            }
        }
    }
    
    public init(clearNavigationStack: Bool = false, presentModallyIfNoViewController: Bool = true, animated: Bool = true)
    {
        self.clearNavigationStack = clearNavigationStack
        self.presentModallyIfNoViewController = presentModallyIfNoViewController
        self.animated = animated
    }
}

public struct ModalPresenter: Presenter {
    /// When this value is set to true, the presented view controller will be wrapped inside a navigation controller, providing a navigation bar. The default value of this field is false.
    public var wrapInNavigationController = false
    public var presentationStyle: UIModalPresentationStyle = ModalPresenter.defaultPresentationStyle
    public var transitionStyle: UIModalTransitionStyle = .coverVertical
    public var animated = true
    public var completion: (() -> Void)? = nil
    
    public static var defaultPresentationStyle: UIModalPresentationStyle {
        if #available(iOS 13.0, *) {
            return .automatic
        } else {
            return .fullScreen
        }
    }
    
    public func present(viewController: UIViewController, inside host: UIViewController) {
        var vc = viewController
        if wrapInNavigationController {
            vc = UINavigationController(rootViewController: vc)
        }
        vc.modalPresentationStyle = presentationStyle
        vc.modalTransitionStyle = transitionStyle
        
        host.present(vc, animated: animated, completion: completion)
    }
    
    public init (wrapInNavigationController: Bool = false,
                 presentationStyle: UIModalPresentationStyle = ModalPresenter.defaultPresentationStyle,
                 transitionStyle: UIModalTransitionStyle = .coverVertical,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil)
    {
        self.wrapInNavigationController = wrapInNavigationController
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
        self.animated = animated
        self.completion = completion
    }
}

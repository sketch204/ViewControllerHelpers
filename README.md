# ViewControllerHelpers

A library that adds helper methods to your view controllers making it easier to present and dismiss them.

### Installation
The preferred way of installing this library is through the Swift Package Manager.

1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency...
1. Paste the repository URL (https://github.com/sketch204/ViewControllerHelpers) and click Next.
1. For Rules, select Branch (with branch set to master).
1. Click Finish.

### Usage

This small library adds three protocols which your `UIViewController`s can implement in order to add easy solutions to common problems.

##### Storyboarded

The functionality added by this protocol is two static functions which ease the process of creating view controllers from storyboards. All you need to do is provide two static properties providing the name of the storyboard that contains this view controller. After that you can simply call `instantiate()` to create a new instance of your view controller.

```swift
class MyViewController: UIViewController, Storyboarded {
    static let storyboardName: String = "Main"
}

let vc = MyViewController.instantiate()
```

There is an additional `storyboardId` parameter which by default is set to the name of the view controller (`MyViewController`, in the example above). This value must be equal to the `Storyboard ID` field of the view controller inside the storyboard, in interface builder. Otherwise you will get a crash when attempting to instantiate this view controller, since UIKit won't be able to find it in the storyboard.


##### Presentable

This protocol is an extension of the `Storyboarded` protocol and adds further functionality for easily presenting your view controllers. Being a sub-protocol of `Storyboarded` it has the same requirements that `Storyboarded` has. However with this protocol you get access to the `present(in:presenter:configuration:)` function, which you can use as shown below.

```swift
class MyViewController: UIViewController, Presentable {
    static let storyboardName: String = "Main"
}

// UINavigationController push presentation
let vc = UIViewController()
let hostVC = UINavigationController(rootController: vc)

MyViewController.present(in: hostVC, presenter: NavigationStackPresenter())

// Or present modally
MyViewController.present(in: hostVC, presenter: ModalPresenter())

// You can also configure the created instance of MyViewController right on the fly.
MyViewController.present(in: hostVC, presenter: ModalPresenter()) { (vc) in
   vc.property = someValue
}
```

Both of the presenters above have extra parameters that you can pass in, such as `clearNavigationStack` or `wrapInNavigationController` which provide extra functionality out of the box. This makes it much easier to present view controllers without storyboard segues.


##### Dismissable

The final protocol is pretty simple. It just adds a  `dismiss()` function that takes no parameters and intelligently dismisses the receiving view controller. By intelligently I mean that:
- If it is inside a navigation controller and is not the only view controller on the stack, it'll pop itself off
- Otherwise it'll dismiss itself completely, navigation controller included.

This can save you sometime since most of the time you don't need precise control and don't really care whether you need to call `UINavigationController.popViewController(animated:completion:)` or `UIViewController.dismiss(animated:completion:)`. You just want the view controller to dismiss itself. This does just that.

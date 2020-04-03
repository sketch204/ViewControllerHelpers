import XCTest
import UIKit
@testable import ViewControllerHelpers

class ViewController: UIViewController, Presentable {
    static var storyboardName: String = "Main"
}

final class ViewControllerHelpersTests: XCTestCase {
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//        XCTAssertEqual(ViewControllerHelpers().text, "Hello, World!")
//    }
    
    func testSomething() {
        let vc = UIViewController()
        ViewController.present(in: vc, presenter: ModalPresenter()) { (vc) in
            
        }
    }

    static var allTests: [(String, () -> Void)] = [
//        ("testExample", testExample),
    ]
}

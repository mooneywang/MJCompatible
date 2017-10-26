/**
 - copyright: Copyright © 2017年 NTT DATA Corporation
 
 製造会社: NTT DATA Corporation
 作成情報: Created by 魏強 on 2017/1/12.
 
 */
import Foundation
import UIKit


extension UIApplication {

    /**
     # 現在表示されたのビュー
     - parameter: なし
     - returns: なし
     */
    func currentViewController() -> UIViewController {
        let rootViewController = UIApplication.shared.windows.last?.rootViewController
        return findTopViewController(rootViewController) as! UIViewController
    }

    /**
     # 現在表示されたのビュー
     - parameter: なし
     - returns: なし
     */
    func findTopViewController(_ inController: UIViewController?) -> AnyObject {

        if (inController?.isKind(of: UITabBarController.classForCoder()))! {
            let viewController = inController as! UITabBarController
            return findTopViewController(viewController.selectedViewController!)

        } else if (inController?.isKind(of: UINavigationController.classForCoder()))! {
            let viewController = inController as! UINavigationController
            return findTopViewController(viewController.visibleViewController!)

        } else if (inController?.isKind(of: UIViewController.classForCoder()))! {
            return inController!
        }  else {
            NSLog("Unhandled ViewController class : %@", inController ?? "");
            return UIViewController();
        }
    }
}

//
//  UIViewController+Extension.swift
//  MJCompatible
//
//  Created by Panda on 2017/7/11.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

public struct UIViewControllerProxy {
    fileprivate let base: UIViewController
    init(proxy: UIViewController) {
        base = proxy
    }
}

extension UIViewController: MJCompatible {
    public typealias CompatibleType = UIViewControllerProxy
    public var mj: UIViewControllerProxy {
        return UIViewControllerProxy(proxy: self)
    }
}

extension UIViewControllerProxy {

    /// Returns the top most view controller from given view controller's stack.
    public static func topMost(of viewController: UIViewController?) -> UIViewController? {
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }

        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }

        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }

        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}

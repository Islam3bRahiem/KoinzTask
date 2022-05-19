//
//  UIApplicationExtension.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return window
    }
    
    static func topViewController(base: UIViewController? = UIApplication.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        else if let topController: UIViewController = UIApplication.keyWindow?.rootViewController {
            return topController
        }
        return base
    }
    
    static func topMostController() -> UIViewController {
        guard var topController: UIViewController = UIApplication.keyWindow?.rootViewController else { return UIViewController() }
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

//
//  Navigator.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

enum NavigatorTypes {
    case push
    case present
    case presentWithNavigation
}

protocol Navigator {
    associatedtype Destination
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes)
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination, coordinator: coordinator)
        switch navigationType {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            viewController.modalPresentationStyle = .overFullScreen
            UIApplication.topMostController().present(viewController, animated: true, completion: nil)
        case .presentWithNavigation:
            let newVC = self.viewController(for: destination, coordinator: coordinator)
            let nav = UINavigationController(rootViewController: newVC)
            nav.modalPresentationStyle = .overFullScreen
            UIApplication.topViewController()?.present(nav, animated: true, completion: nil)
        }
    }
}

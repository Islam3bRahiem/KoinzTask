//
//  AppCoordinator.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var Search: SearchNavigator { get }
    var navigationController: UINavigationController? { get }
    func start()
    func dismiss()
}

class AppCoordinator: Coordinator {
    let window: UIWindow
        
    lazy var Search: SearchNavigator = {
        return .init(coordinator: self)
    }()
    
    var navigationController: UINavigationController? {
        if let navigationController = UIApplication.topMostController() as? UINavigationController {
            return navigationController
        }
        return nil
    }
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        //UIAppearance
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        } else { }
    }
    
    func start(){
        let searchRepo = SearchRepositoryImpl()
        let searchUseCase = SearchUseCase(searchRepository: searchRepo)
        let viewModel = SearchViewModel(searchUseCase: searchUseCase)
        let scene = SearchVC(viewModel: viewModel, coordinator: self)
        window.rootViewController = scene
        window.makeKeyAndVisible()
    }

    func dismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        UIApplication.topMostController().dismiss(animated: true, completion: nil)
    }
}

//
//  SearchNavigator.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

class SearchNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case Search
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .Search:
            let viewModel = SearchViewModel()
            let scene = SearchVC(viewModel: viewModel, coordinator: coordinator)
            return scene
        }
    }
}

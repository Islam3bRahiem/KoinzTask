//
//  SwipeRefresh.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit


/** contract of swipe **/
protocol SwipeRefreshProtocol {
    func swipeButtomRefresh(closure: @escaping (() -> Void))
}

extension UIScrollView: SwipeRefreshProtocol {
    
    func swipeButtomRefresh(closure: @escaping (() -> Void)) {
        if (self.contentOffset.y + self.frame.size.height) >= self.contentSize.height {
            closure()
        }
    }
}

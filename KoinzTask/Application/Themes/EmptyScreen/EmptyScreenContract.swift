//
//  EmptyScreenContract.swift
//  geoshield
//
//  Created by Mabdu on 08/04/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

protocol EmptyScreenContract: AnyObject {
    func showEmptyScreen(for top: CGFloat, for bottom: CGFloat, title: String?, body: String?)
    func hideEmptyScreen()
}


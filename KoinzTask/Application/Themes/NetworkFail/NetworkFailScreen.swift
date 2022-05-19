//
//  CategoryStoresModel.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/8/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class NetworkFailScreen: UIView {
   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tryAgainBtn: UIButton!

    var tryAgainBtnClicked: (() -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
        updateView()
    }
    
    func initNib() {
        let bundle = Bundle(for: NetworkFailScreen.self)
        bundle.loadNibNamed("NetworkFailScreen", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }
    func updateView() {
        tryAgainBtn.layer.cornerRadius = 12
    }
    @IBAction func tryAgain(_ sender: Any) {
        if let tryAgainBtnClicked = tryAgainBtnClicked {
            tryAgainBtnClicked()
        }
    }
}



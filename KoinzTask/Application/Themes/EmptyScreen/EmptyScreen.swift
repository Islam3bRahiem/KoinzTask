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
class EmptyScreen: UIView {
   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emptyImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!

    private var title: String? = nil
    private var descriptions: String? = nil
    private var messageImage: UIImage? = nil
    private var withAction: Bool = true

    lazy var actionButton: (()->(Void))? = nil

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
        let bundle = Bundle(for: EmptyScreen.self)
        bundle.loadNibNamed("EmptyScreen", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }

    func updateView() {
    }

    func setUI(title: String? = nil, description: String? = nil,  messageImage: UIImage? = nil) {
        if let messageImage = messageImage {
            emptyImg.image = messageImage
        }
        titleLbl.text = title
        bodyLbl.text = description
        bodyLbl.isHidden = (description?.isEmpty ?? true)
    }
}



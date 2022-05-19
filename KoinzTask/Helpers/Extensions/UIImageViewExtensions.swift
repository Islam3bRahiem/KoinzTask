//
//  UIImageViewExtensions.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Kingfisher

#if !os(watchOS)
// MARK: - Methods
public extension UIImageView {
    func setImage(url: String?, placeholder: Placeholder? = nil) {
        let removingPercentEncodingURL = url?.removingPercentEncoding
        let safeURL = removingPercentEncodingURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let imageURL = URL(string: safeURL ?? "")
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL, placeholder: placeholder)
    }
}
#endif

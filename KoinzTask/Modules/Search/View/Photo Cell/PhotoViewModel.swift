//
//  PhotoViewModel.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

class PhotoViewModel {
    
    var adsBannerImg: UIImage?
    var imageURL: String
    
    init(_ url: String) {
        self.adsBannerImg = nil
        self.imageURL = url
    }
    
    init(_ image: UIImage?) {
        self.adsBannerImg = image
        self.imageURL = ""
    }
    
    //Schema:- https://farm66​{farm}​.static.flickr.com/​{server}​/​{id}​_​{secret}​.jpg
    init(_ model: PhotoModel) {
        self.adsBannerImg = nil
        self.imageURL = "https://farm66.static.flickr.com/\(model.server)/\(model.id)_\(model.secret).jpg"
    }
    
}

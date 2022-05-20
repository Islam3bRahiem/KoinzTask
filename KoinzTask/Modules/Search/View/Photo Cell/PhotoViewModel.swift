//
//  PhotoViewModel.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation

class PhotoViewModel {
    
    var imageURL: String
    
    init(_ model: PhotoModel) {
        //Schema :     http://farm​{farm}​.static.flickr.com/​{server}​/​{id}​_​{secret}​.jpg
        self.imageURL = "https://farm66.static.flickr.com/\(model.server)/\(model.id)_\(model.secret).jpg"
    }
    
}

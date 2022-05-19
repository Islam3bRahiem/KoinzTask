//
//  SearchResponseModel.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable {
    var photos: PhotosModel
    var stat: String
    var code: Int?
    var message: String?
}

// MARK: - Photos
struct PhotosModel: Codable {
    var page, pages, perpage, total: Int
    var photo: [PhotoModel]
}

// MARK: - PhotoModel
struct PhotoModel: Codable {
    var id, owner, secret, server: String
    var farm: Int
    var title: String
    var ispublic, isfriend, isfamily: Int
}

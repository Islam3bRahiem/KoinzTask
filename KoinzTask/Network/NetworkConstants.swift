//
//  NetworkConstants.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}


class NetworkConstants {
    static let baseUrl = "https://www.flickr.com/services/rest/"
    static let apiKey = "d17378e37e555ebef55ab86c4180e8dc"
    static let format = "json"
    
    // MARK: - ...  The Endpoints
    public enum EndPoint: String {
        case search = "flickr.photos.search"
    }

}

enum ResponseError: Error {
    case URLNotValid
    case DataNotFound
    case DecoderError

}

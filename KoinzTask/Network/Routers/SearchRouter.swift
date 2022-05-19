//
//  SearchRouter.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire

enum SearchRouter: APIRouter {
    case forecast(String)
    
    var method: HTTPMethod {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "forecast"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .forecast(let key):
            let parameters = [
                "method": "flickr.photos.search",
                "format": NetworkConstants.format,
                "nojsoncallback": 50,
                "text": key,
                "page": 1,
                "per_page": 20,
                "api_key":NetworkConstants.apiKey
            ] as [String : Any]
            return parameters
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .forecast:
            return URLEncoding.default
        }
    }


}

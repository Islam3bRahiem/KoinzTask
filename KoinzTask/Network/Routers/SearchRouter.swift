//
//  SearchRouter.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire

enum SearchRouter: APIRouter {
    case forecast(String, Int)
    
    var method: HTTPMethod {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .forecast:
            return ""
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .forecast(let key, let page):
            let parameters = [
                "method": NetworkConstants.EndPoint.search.rawValue,
                "format": NetworkConstants.format,
                "nojsoncallback": 50,
                "text": key,
                "page": page,
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

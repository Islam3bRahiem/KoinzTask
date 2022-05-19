//
//  APIRouter.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }

}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        guard var url: URL = URL(string: NetworkConstants.baseUrl) else {
            throw ResponseError.URLNotValid
        }
        url.appendPathComponent(path)
        let request = try URLRequest(url: url, method: method, headers: nil)
        return try encoding.encode(request, with: parameters)
    }
}

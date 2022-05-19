//
//  NetworkClient.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire

class NetworkClient {
    
    func performRequest<T: Decodable>(_ object: T.Type, router: APIRouter, completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(router).responseJSON { (response) in
            print("♥️ response is:", response)
            do {
                let models = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                completion(.success(models))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

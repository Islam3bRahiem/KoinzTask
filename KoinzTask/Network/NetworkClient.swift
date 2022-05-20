//
//  NetworkClient.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import Alamofire


protocol NetworkClientProtocol {
    func performRequest<T: Decodable>(_ object: T.Type, router: APIRouter, completion: @escaping ((Result<T, Error>) -> Void))
}

class NetworkClient: NetworkClientProtocol {
    
    func performRequest<T: Decodable>(_ object: T.Type, router: APIRouter, completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(router).responseJSON { (response) in
            print("♥️ response is:", response)
            
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let models = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(models))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
//            do {
//                let models = try JSONDecoder().decode(T.self, from: response.data ?? Data())
//                completion(.success(models))
//            } catch let error {
//                completion(.failure(error))
//            }
        }
    }    
}

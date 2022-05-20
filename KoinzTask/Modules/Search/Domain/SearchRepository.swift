//
//  SearchRepository.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchRepository {
    func fetchSearchData(_ key: String) -> Observable<SearchResponseModel>
}

class SearchRepositoryImpl: SearchRepository {
    private var page: Int = 1
    let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchSearchData(_ key: String) -> Observable<SearchResponseModel> {
        Observable<SearchResponseModel>.create { [weak self] (item) -> Disposable in
            guard let self = self else {
                return Disposables.create()
            }
            self.networkClient.performRequest(SearchResponseModel.self, router: SearchRouter.forecast(key, self.page)) { (result) in
                switch result {
                case .success(let data):
                    item.onNext(data)
                    let currentPage = data.photos.page
                    self.page = currentPage + 1
                case .failure(let error):
                    print(error)
                    item.onError(error)
                }
            }
            return Disposables.create()
        }
    }


    //Private functions
    private func saveDataToDataBase(_ response: SearchResponseModel) {
//        CashManager.shared.save(response)
    }
    private func fetchDataFromDatabase(_ item: AnyObserver<SearchResponseModel>, for key: String, error: Error) {
//        CashManager.shared.fetchCity(cityName: cityName) { [weak self](success, response) in
//            guard self != nil else { return }
//            if success {
//                item.onNext(response!)
//                item.onCompleted()
//            } else {
//                item.onError(error)
//            }
//        }
    }

}

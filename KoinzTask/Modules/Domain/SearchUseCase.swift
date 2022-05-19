//
//  SearchUseCase.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class SearchUseCase {

    let searchRepository: SearchRepository
    let disposeBag = DisposeBag()

    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }

    func executePhotosFetch(_ key: String) -> Observable<SearchResponseModel>{
        let observable = searchRepository.fetchSearchData(key)
        observable.subscribe { (item) in
            // TODO :- nothing
        }.disposed(by: disposeBag)
        return observable
    }

}

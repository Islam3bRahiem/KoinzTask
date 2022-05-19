//
//  SearchViewModel.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - ... Inputs
protocol SearchViewModelInput {
    func searchForPhotos(with key: String)
    func fetchMorePhotos(with key: String)
}

// MARK: - ... Outputs
protocol SearchViewModelOutput {
    var photosObservable: Observable<[PhotoViewModel]> { get }
    var emptyTableView: PublishSubject<Bool> { get }
}


// MARK: - ...  ViewModel
class SearchViewModel: BaseViewModel, SearchViewModelInput, SearchViewModelOutput {

    // Properties
    private let searchUseCase: SearchUseCase
    private var photosBehavior: BehaviorRelay<[PhotoViewModel]> = .init(value: [])
    private var canPaginate: Bool = true

    
    init(searchUseCase: SearchUseCase) {
        photosObservable = photosBehavior.asObservable()
        self.searchUseCase = searchUseCase
    }
    
    // Outputs
    var photosObservable: Observable<[PhotoViewModel]>
    var emptyTableView: PublishSubject<Bool> = .init()

    
    // Inputs
    func searchForPhotos(with key: String) {
        isLoading.onNext(true)
        searchUseCase.executePhotosFetch(key).subscribe { [weak self] (response) in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            if response.stat == ResponseCode.Success.rawValue {
                let responsePhotos = response.photos.photo
                let responsePhotosViewModels = responsePhotos.map(PhotoViewModel.init)
                let allPhotos = self.photosBehavior.value + responsePhotosViewModels
                self.photosBehavior.accept(allPhotos)
                self.emptyTableView.onNext(allPhotos.isEmpty)
                self.canPaginate = response.photos.page < response.photos.pages
            } else {
                self.displayToastMessage.onNext(response.message ?? "")
            }
        } onError: { [weak self] (error) in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            self.displayToastMessage.onNext(ResponseError.URLNotValid.localizedDescription)
        }.disposed(by: disposeBag)
    }
        
    func fetchMorePhotos(with key: String) {
        if canPaginate {
            self.searchForPhotos(with: key)
        }
    }
}

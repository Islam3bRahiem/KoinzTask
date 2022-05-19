//
//  BaseViewModel.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    var disposeBag: DisposeBag { get }
    var isLoading: PublishSubject<Bool> { get }
    var displayToastMessage: PublishSubject<String> { get }
    var noInternetConnection: PublishSubject<String> { get }
}

class BaseViewModel: ViewModel {
    var disposeBag = DisposeBag()
    var isLoading: PublishSubject<Bool> = .init()
    var displayToastMessage: PublishSubject<String> = .init()
    var noInternetConnection: PublishSubject<String> = .init()
}

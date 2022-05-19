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

}

class BaseViewModel: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayToastMessage: PublishSubject<String> = .init()
    var noInternetConnection: PublishSubject<String> = .init()
}

//
//  BaseController.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Toast_Swift

protocol BaseControllerFunctions {
    func makeAlert(with message: String)
}

class BaseController<T: BaseViewModel>: UIViewController {

    //MARK:- ... Properties
    var viewModel: T
    var coordinator: Coordinator

    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()

    //MARK:- ... Init
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        bindStates()
    }
    
    //MARK:- ... Functions
    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    
    private func bindStates(){
        viewModel.isLoading
            .subscribe { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading.element else { return }
            if isLoading {
                self.view.makeToastActivity(.center)
            }
            else {
                self.view.hideToastActivity()
            }
        }.disposed(by: disposeBag)
        
        viewModel.displayToastMessage.subscribe { [unowned self] (text) in
            self.makeAlert(with: text)
        }.disposed(by: disposeBag)

        viewModel.noInternetConnection.subscribe {  [unowned self] (text) in
            self.makeAlert(with: "No Internet Connection")
        }.disposed(by: disposeBag)
    }
    
}


extension BaseController: BaseControllerFunctions {
    func makeAlert(with message: String) {
        self.view.makeToast(message, position: .top)
    }

}

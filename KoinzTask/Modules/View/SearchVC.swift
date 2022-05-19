//
//  SearchVC.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import UIKit

class SearchVC: BaseController<SearchViewModel> {

    // MARK: - ... Variables
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(nibWithCellClass: PhotoCell.self)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

    private var searchKey: String = "Color"

    
    // MARK: - ... LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewLayout()
        viewModel.searchForPhotos(with: searchKey)
    }
    
    // MARK: - ... Binding
    override func bind(viewModel: SearchViewModel) {
        bindTableview()
        
        viewModel.emptyTableView
            .subscribe { [weak self] (empty) in
                guard let self = self,
                let empty = empty.element else { return }
                self.tableView.restore()
                if empty {
                    let emptyScreen = EmptyScreen()
                    self.tableView.backgroundView = emptyScreen
                }
        }.disposed(by: disposeBag)
    }
    
    private func bindTableview() {
        viewModel.photosObservable
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: PhotoCell.self),
                                         cellType: PhotoCell.self)) { index, model, cell in
                cell.bind(model)
        }.disposed(by: disposeBag)
    }
    
}

// MARK: - ...  Functions - Actions
extension SearchVC {
    private func tableViewLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
    }
}


// MARK: - ...  UITableView Delegate
extension SearchVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.swipeButtomRefresh { [weak self] in
            guard let self = self else { return }
            self.viewModel.fetchMorePhotos(with: self.searchKey)
        }
    }

}

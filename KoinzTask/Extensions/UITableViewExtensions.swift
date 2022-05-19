//
//  UITableViewExtensions.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

// MARK: - Methods
extension UITableView {

    /// SwifterSwift: check if table view is empty or not.
    ///
    /// - Returns: isEmpty or not.
    var isEmpty: Bool {
        return self.numberOfRows() == 0
    }

    /// SwifterSwift: Number of all rows in all sections of tableView.
    ///
    /// - Returns: The count of all rows in the tableView.
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    /// SwifterSwift: Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }


    /// SwifterSwift: Register UITableViewCell with .xib file using only its corresponding class.
    ///               Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - bundleClass: Class in which the Bundle instance will be based on.
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    /// SwifterSwift: Check whether IndexPath is valid within the tableView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }


    /// SwifterSwift: set tableView background with empty View
    ///
    /// - EmptyView : is a view of image and lable
    func setNoInternetConnectionView(description: String = "NO Internet Connection") {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

        let tryButton = UIButton()
        tryButton.setTitle("Try Again", for: .normal)
        tryButton.setTitleColor(.black, for: .normal)
        tryButton.layer.cornerRadius = 8
        tryButton.layer.borderColor = UIColor.black.cgColor
        tryButton.layer.borderWidth = 1
        tryButton.translatesAutoresizingMaskIntoConstraints = false

        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor =  .black
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = description

        emptyView.addSubview(descriptionLabel)
        emptyView.addSubview(tryButton)

        descriptionLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -40).isActive = true
        tryButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        tryButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tryButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25).isActive = true
        tryButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    /// SwifterSwift: set backgroundView is nil
    func restore() {
        self.backgroundView = nil
    }

}

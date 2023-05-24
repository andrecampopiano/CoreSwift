//
//  UITableView.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import UIKit

extension UITableView {
    
    /// Quicker way to dequeue a cell based on its type.
    /// - Parameters:
    ///   - cellType: Class type of the cell to be dequeued.
    ///   - indexPath: Location of the cell within the table view.
    /// - Returns: The dequeued cell.
    public func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell of class \(cellType.className).")
        }
        return cell
    }
    
    /// Quicker way to register a table view cell.
    /// - Parameter cellType: Class type of the cell to be registered.
    public func registerCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: cellType.className)
    }
    
    /// Quicker way to register a nib object containing a table view cell.
    /// - Parameter cellType: Class type of the cell to be registered.
    /// - Parameter bundle: Bundle of the module
    public func registerNib<T: UITableViewCell>(_ cellType: T.Type, bundle: Bundle) {
        let nib = UINib(nibName: cellType.className, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.className)
    }
}

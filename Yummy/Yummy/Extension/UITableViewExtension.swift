//
//  UITableViewExtension.swift
//  Yummy
//
//  Created by varol on 12.01.2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib<T: UITableViewCell>(cell: T.Type) {
        register(UINib(nibName: cell.reuseID, bundle: .main), forCellReuseIdentifier: cell.reuseID)
    }
    
    func dequeCell<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: cell.reuseID, for: indexPath) as? T
    }
    
}

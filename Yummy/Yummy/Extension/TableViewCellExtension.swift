//
//  TableViewCellExtension.swift
//  Yummy
//
//  Created by varol on 12.01.2022.
//

import Foundation
import UIKit

protocol CellIdentifier {
    static var reuseID: String { get }
}

extension CellIdentifier {
    static var reuseID: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: CellIdentifier {}
extension UICollectionViewCell: CellIdentifier {}

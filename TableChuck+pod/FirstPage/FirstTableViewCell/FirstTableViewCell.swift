//
//  FirstTableViewCell.swift
//  TableChuck+pod
//
//  Created by Vladislav Pashkevich on 2.11.21.
//

import Foundation
import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func update(with text: String) {
        titleLabel.text = text
    }
}

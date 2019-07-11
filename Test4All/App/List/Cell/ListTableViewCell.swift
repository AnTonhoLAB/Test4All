//
//  ListTableViewCell.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    // Class constants
    static let identifier = "ListTableViewCell"
    
    // Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // Functions
    func setup(_ withId: String) {
        self.titleLabel.text = withId
    }
}

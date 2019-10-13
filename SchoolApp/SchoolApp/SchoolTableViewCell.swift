//
//  SchoolTableViewCell.swift
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/12/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    static let identifier = "SchoolTableViewCell"
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    
    var school: School! {
        didSet {
            schoolNameLabel.text = school.school_name
            cityLabel.text = school.city
        }
    }
}

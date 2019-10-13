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
    @IBOutlet weak var navigateButton: UIButton!

    var school: School! {
        didSet {
            schoolNameLabel.text = school.school_name
            if let city = school.city, let code = school.state_code, let zip = school.zip{
                cityLabel.text = "\(city), \(code), \(zip)"
            }
        }
    }
}

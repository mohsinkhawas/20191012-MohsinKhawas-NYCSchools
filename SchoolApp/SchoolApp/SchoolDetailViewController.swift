//
//  SchoolDetailViewController.swift
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/13/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var readingSATScoreLabel: UILabel!
    @IBOutlet weak var mathSATScoreLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    @IBOutlet weak var addressLineLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var faxNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadDetailView(_ school: School){
                
        schoolNameLabel.text = school.school_name
        
        if let readingScore = school.satScores?.sat_critical_reading_avg_score{
            readingSATScoreLabel.text = "SAT Average Reading Score - " + readingScore
        }
        
        if let writingScore = school.satScores?.sat_writing_avg_score{
            writingLabel.text = "SAT Average Writing Score - " + writingScore
        }
        
        if let mathsScore = school.satScores?.sat_math_avg_score{
            mathSATScoreLabel.text = "SAT Average Maths Score - " + mathsScore
        }
        
        
        addressLineLabel.text = school.primary_address_line_1
        
        if let city = school.city, let code = school.state_code, let zip = school.zip{
            cityLabel.text = "\(city), \(code), \(zip)"
        }
        websiteLabel.text = school.website
        
        phoneNumberLabel.text = school.phone_number
        emailLabel.text = school.school_email
        faxNumberLabel.text = school.fax_number
    }
}


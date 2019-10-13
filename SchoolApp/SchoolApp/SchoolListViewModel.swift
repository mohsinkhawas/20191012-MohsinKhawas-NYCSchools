//
//  SchoolListViewModel.swift
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/12/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import Foundation

protocol SchoolListViewControllerDelegate: class {
    func fetchSchoolListSuccess()
    func fetchSchoolListFailed(_ error: Error)
    
    func fetchSATSuccess()
    func fetchSATFailed(_ error: Error)
}

class SchoolListViewModel: NSObject {
    private var schools: [School] = []
    let networkManager = NetworkManager()
    
    weak var delegate: SchoolListViewControllerDelegate?
    
    init(_ delegate: SchoolListViewControllerDelegate) {
        super.init()
        
        self.delegate = delegate
        self.fetchSchools()
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return schools.count
    }
    
    func data(forRowAt indexPath: IndexPath) -> School {
        return schools[indexPath.row]
    }
    
    func fetchSchools(){
        networkManager.fetchData(urlString: APIURLConstants.fetchSchools) { (resultData, fetchError) in
            do{
                let schoolList = try JSONDecoder().decode(Array<School>.self, from: resultData as! Data)
                
                self.schools = schoolList
                self.delegate?.fetchSchoolListSuccess()
                self.fetchSATScores()
                
                }catch{
                    self.delegate?.fetchSchoolListFailed(error)
                }
                self.delegate?.fetchSchoolListFailed(fetchError!)
            }
    }
    
    func fetchSATScores(){
        networkManager.fetchData(urlString: APIURLConstants.fetchSATScores) { (resultData, fetchError)  in
            do{
                let schoolSATScores = try JSONDecoder().decode(Array<SchoolSATScores>.self, from: resultData as! Data)
                print(schoolSATScores)
                
                self.delegate?.fetchSATSuccess()
            }catch{
                print(error.localizedDescription)
                self.delegate?.fetchSATFailed(error)
            }
            self.delegate?.fetchSATFailed(fetchError!)
        }
    }
}

//
//  ViewController.swift
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/12/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import UIKit
import MapKit

class SchoolListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var alertController: UIAlertController?
    var isAnimating = false
    
    var viewModel: SchoolListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SchoolListViewModel(self)
        
        self.title = "NYC Schools"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //for first time.
        self.startAnimation()
    }
    
    //Animate view while fetching results.
    func startAnimation(){
        if (self.isAnimating == false){
            self.isAnimating = true
            self.alertController = UIAlertController(title: nil, message: "Fetching Schools...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.startAnimating();
            
            self.alertController?.view.addSubview(loadingIndicator)
            present(self.alertController!, animated: true, completion: nil)
        }
    }
    
    func stopAnimation(){
        self.alertController?.dismiss(animated: true, completion: nil)
        self.alertController = nil
        self.isAnimating = false
    }
    
    //Function to throw alert.
    func displayAlert(_ error: Error) {
        
        DispatchQueue.main.async{
            self.dismiss(animated: false) {
                OperationQueue.main.addOperation {
                    print("Error while fetching Schools.")
                    print(error.localizedDescription)
                    
                    let alert = UIAlertController(title: "Error while fetching details.", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        print("Error while fetching details.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let school = sender as? School {
            let detailsView = segue.destination as? SchoolDetailViewController
            detailsView?.view.tag = 0   //Setting the tag as example so that view loads it hierarchy.
            detailsView?.loadDetailView(school)
        }
    }
    
    @objc func navigateToAddress(_ sender: UIButton){
        
        let indexPath = IndexPath.init(row: sender.tag, section: 0)
        let selectedSchool = viewModel?.data(forRowAt: indexPath)
        
        if let highSchoolCoordinate = self.getCoordinates(selectedSchool?.location){
            let coordinate = CLLocationCoordinate2DMake(highSchoolCoordinate.latitude, highSchoolCoordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            
            if let name = selectedSchool?.school_name{
                mapItem.name = name
            }
            
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    func getCoordinates(_ location: String?) -> CLLocationCoordinate2D?{
        if let schoolAddress = location{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
}

extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.identifier) as! SchoolTableViewCell
            cell.school = viewModel!.data(forRowAt: indexPath)
        
        //Add button action
        cell.navigateButton.tag = indexPath.row
        cell.navigateButton.addTarget(self, action: #selector(self.navigateToAddress(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension SchoolListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let school = viewModel!.data(forRowAt: indexPath)
        self.performSegue(withIdentifier: "mainToDetailSegue", sender: school)
    }
}

extension SchoolListViewController: SchoolListViewControllerDelegate {

    func fetchSchoolListSuccess(_ failedError: Error?){
        
        if let error = failedError {
            self.displayAlert(error)
        }else{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.stopAnimation()
            }
        }
    }
    
    func fetchSATSuccess(_ failedError: Error?){
        if let error = failedError {
            self.displayAlert(error)
        }
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

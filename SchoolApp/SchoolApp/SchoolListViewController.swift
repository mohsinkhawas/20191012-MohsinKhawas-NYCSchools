//
//  ViewController.swift
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/12/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

import UIKit

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
}

extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.identifier) as! SchoolTableViewCell
        
//        cell.repository = viewModel!.data(forRowAt: indexPath)
        
        return cell
    }
}


extension SchoolListViewController: SchoolListViewControllerDelegate {
    
    
    func fetchSchoolListSuccess(){
        DispatchQueue.main.async {
            //            self.tableView.reloadData()
            //            self.stopAnimation()
        }
    }
    func fetchSchoolListFailed(_ error: Error){
        self.displayAlert(error)
    }
    
    func fetchSATSuccess(){
        
    }
    func fetchSATFailed(_ error: Error){
        self.displayAlert(error)
    }
}

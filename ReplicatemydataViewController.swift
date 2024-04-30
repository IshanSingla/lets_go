//
//  ReplicatemydataViewController.swift
//  lets_go
//
//  Created by student on 30/04/24.
//

import UIKit

class ReplicatemydataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct allRideScene{
        let userName: String
        let From: String
        let To: String
        let noOfSeatsAvailable: Int
        let timeOfDeparture: Date
        let price: Double
    }
    
    
    
   /* let data:  [allRideScene] = [
        allRideScene(userName: "Ram", From: "Chitkara University", To: "Sector 23 Chandigarh" , noOfSeatsAvailable: 3, timeOfDeparture: , price: 120)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }*/
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

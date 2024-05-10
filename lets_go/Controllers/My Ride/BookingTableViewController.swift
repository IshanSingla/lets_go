//
//  BookingTableViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 09/05/24.
//

import UIKit

class BookingTableViewController: UITableViewController {
    var ride: Rides!
    var bookings: [Booking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 4
        return bookings.count + num
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.count==0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTimePriceRequest", for: indexPath)
            return cell
            
        }else if (indexPath.count==1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPathRequest", for: indexPath)
            return cell
            
        }else if (indexPath.count==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCRequest", for: indexPath)
            return cell
            
        }else if (indexPath.count==3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCarDetailsRequest", for: indexPath)
            return cell
            
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "allRequestsCell", for: indexPath)
            return cell
    }
    
    
}

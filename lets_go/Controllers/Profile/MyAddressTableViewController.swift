//
//  MyAddressTableViewController.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import UIKit

class MyAddressTableViewController: UITableViewController {
    
    private var data: [Address] = [
        Address(
            id: "1",
            userId: "1",
            address: "Chitkara University",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        ),
        Address(
            id: "1",
            userId: "1",
            address: "118/2 Rajpura",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        ),
        Address(
            id: "1",
            userId: "1",
            address: "118/2 Kaithal",
            city: "Rajpura",
            state: "Punjab",
            country: "India",
            pincode: "140401"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! AddressTableViewCell
        
        // Configure the cell...
        let address = data[indexPath.row]
        cell.address.text = "\(address.address) \(address.city)"
        cell.country.text = "\(address.state), \(address.country)"
        cell.pin.text = "\(address.pincode)"
//        cell.textLabel?.text =  "\(address.address) \(address.city)"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func addAddress(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Address", message: "Enter new address", preferredStyle: .alert)
                
                alert.addTextField { textField in
                    textField.placeholder = "Address"
                }
                
                let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
                    guard let address = alert.textFields?.first?.text, !address.isEmpty else { return }
                    self?.addNewAddress(address)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                alert.addAction(addAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
            }
            
            func addNewAddress(_ address: String) {
                let newAddress = Address(
                    id: UUID().uuidString,
                    userId: "1",
                    address: address,
                    city: "New City",
                    state: "New State",
                    country: "New Country",
                    pincode: "123456"
                )
                data.append(newAddress)
                tableView.reloadData()
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedAddress = data[indexPath.row]
            let alert = UIAlertController(title: "Update Address", message: "Enter updated address", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.text = "\(selectedAddress.address), \(selectedAddress.city)"
            }
            
            let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
                guard let address = alert.textFields?.first?.text, !address.isEmpty else { return }
                self?.updateAddress(at: indexPath, with: address)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(updateAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
        
    @IBAction func updateAddress( at indexPath: IndexPath, with address: String) {
        data[indexPath.row].address = address
                tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
            
       

}

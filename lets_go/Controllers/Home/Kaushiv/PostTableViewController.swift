//
//  PostTableViewController.swift
//  lets_go
//
//  Created by student on 29/04/24.
//

import UIKit

class PostTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var toText: UITextField!
    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var seatNo: UILabel!
    @IBOutlet weak var seatCount: UIStepper!

    @IBOutlet weak var offerPrice: UITextField!
    private var fromAddress: Address! {
        didSet {
            fromText.text = "\(self.fromAddress.address) \(self.fromAddress.city) \(self.fromAddress.state)"
            fromText.resignFirstResponder()
        }
    }
    private var toAddress: Address! {
        didSet {
            toText.text = "\(self.toAddress.address) \(self.toAddress.city) \(self.toAddress.state)"
            toText.resignFirstResponder()
        }
        
    }
    private var seatNumber: Int = 0 {
        didSet {
            seatNo.text = "\(Int(seatCount.value))"
        }
    }
    
    private var user: User!
    
    private var rideService: RideService!
    private var authService: AuthService!
    private var address: [Address] = []
    private let fromPlacePickerView = UIPickerView()
    private let toPlacePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AuthService()
        rideService = RideService()
        fromPlacePickerView.dataSource = self
        fromPlacePickerView.delegate = self
        toPlacePickerView.dataSource = self
        toPlacePickerView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        datePicker.minimumDate = Date()
        seatCount.maximumValue = 4
        
        if let user = try? authService.getCurrentUser() {
            var addresses = try! authService.getAddressesCurrentUser()
            address = [user.college!.address]
            for x in addresses {
                address.append(x)
            }
        }

        fromText.inputView = fromPlacePickerView
        toText.inputView = toPlacePickerView
    }

    @IBAction func StepperChange(_ sender: UIStepper) {
        seatNumber = Int(seatCount.value)
    }
    
    @IBAction func handlePost(_ sender: Any) {
        guard let fromAddress = fromAddress, !fromAddress.address.isEmpty,
                      let toAddress = toAddress, !toAddress.address.isEmpty,
                      seatNumber > 0,
                      datePicker.date > Date() else {
                    // Show alert to inform the user to fill all required fields
                    let alert = UIAlertController(title: "Incomplete Information", message: "Please fill all required fields.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
        if let user = try? authService.getCurrentUser() {
            var ride: Rides = Rides(
                userId: user.id,
                vehicleId: user.vehicles!.first!.id,
                fromId: fromAddress.id,
                toId: toAddress.id,
                totalNoOfSeets: Int(seatCount.value),
                noOfSeetsAvailable: Int(seatCount.value),
                costPerSeet: Float(offerPrice.text ?? "")!,
                dateTime: datePicker.date
            )
            rideService.createRide(ride: ride)
        }
        if let tabBarController = self.tabBarController {
            // Set the index of the tab you want to select
            tabBarController.selectedIndex = 1 // Change 2 to the index of the tab you want to select
        }
    }

   
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        header.textLabel?.frame = CGRect(x: 12, y: 0, width: 300, height: 20)
        
        datePicker.minimumDate = Date()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        address.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let current = address[row]
        return "\(current.address) \(current.city) \(current.state)"
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPlacePickerView {
            fromAddress = address[row]
        } else {
            toAddress = address[row]
        }
    }
}

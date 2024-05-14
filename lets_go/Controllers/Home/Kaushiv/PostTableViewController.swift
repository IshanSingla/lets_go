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
    private var authService: AuthService = AuthService()
    private var address: [Address] = []
    private let fromPlacePickerView = UIPickerView()
    private let toPlacePickerView = UIPickerView()
    
    @IBAction func handlePost(_ sender: Any) {
        if let tabBarController = self.tabBarController {
            // Set the index of the tab you want to select
            tabBarController.selectedIndex = 1 // Change 2 to the index of the tab you want to select
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    func updateCount(){
        seatNo.text = "\(Int(seatCount.value))"
    }
    @IBAction func StepperChange(_ sender: UIStepper) {
        updateCount()
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

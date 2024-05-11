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
    //    @IBOutlet weak var toPlacePickerView: UIPickerView!
//    @IBOutlet weak var fromPlacePickerView: UIPickerView!
    @IBOutlet weak var toText: UITextField!
    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var seatNo: UILabel!
    @IBOutlet weak var seatCount: UIStepper!
    
    private var fromOptions: [String] = []
    private var toOptions: [String] = []
    private let fromPlacePickerView = UIPickerView()
    private let toPlacePickerView = UIPickerView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seatCount.maximumValue = 4
        
        fromOptions = ["Chitkara University", "Sector 23 chandigarh", "Rajpura", "Ambala", "Zirakpur","Panchkula","Patiala"]
        toOptions = ["Chitkara University", "Sector 23 chandigarh", "Rajpura", "Ambala", "Zirakpur","Panchkula","Patiala"]
        
        fromPlacePickerView.dataSource = self
        fromPlacePickerView.delegate = self
        
        toPlacePickerView.dataSource = self
        toPlacePickerView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fromPlacePickerView {
            return fromOptions.count
        } else {
            return toOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fromPlacePickerView {
            return fromOptions[row]
        } else {
            return toOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPlacePickerView {
            // Code to handle the selection of an item
            fromText.text = fromOptions[row]
                        fromText.resignFirstResponder()
        } else {
            toText.text = toOptions[row]
                        toText.resignFirstResponder()
            // Code to handle the selection of an item
        }
  }
}

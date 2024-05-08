//
//  PostTableViewController.swift
//  lets_go
//
//  Created by student on 29/04/24.
//

import UIKit

class PostTableViewController: UITableViewController,  UIPickerViewDataSource, UIPickerViewDelegate  {


 
    @IBOutlet weak var toPlacePickerView: UIPickerView!
    @IBOutlet weak var fromPlacePickerView: UIPickerView!
    @IBOutlet weak var toText: UITextField!
    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var seatNo: UILabel!
    @IBOutlet weak var seatCount: UIStepper!
    
    private var fromOptions: [String]!
    private var toOptions: [String]!
    
    
//    let fromTextIndexPath = IndexPath(row: 0, section: 0)
//    let fromPlacePickerViewIndexPath = IndexPath(row: 1, section: 0)
//    let toTextIndexPath = IndexPath(row: 2, section: 0)
//    let toPlacePickerViewIndexPath = IndexPath(row: 3, section: 0)
//
//    var isfromPlacePickerViewVisible:Bool = false{
//        didSet{
//            fromPlacePickerView.isHidden = !isfromPlacePickerViewVisible
//        }
//        
//    }
//    var istoPlacePickerViewVisible:Bool = false{
//        didSet{
//            toPlacePickerView.isHidden = !istoPlacePickerViewVisible
//        }
//        
//    }
    
    
    
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath{
//        case fromPlacePickerViewIndexPath where isfromPlacePickerViewVisible == false : return 0
//        case toPlacePickerViewIndexPath where istoPlacePickerViewVisible == false : return 0
//        default: return UITableView.automaticDimension
//        }
//    }
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath{
//        case fromPlacePickerViewIndexPath: return 190
//        case toPlacePickerViewIndexPath: return 190
//        default: return UITableView.automaticDimension
//        }
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if(indexPath == fromTextIndexPath && istoPlacePickerViewVisible == false){
//            isfromPlacePickerViewVisible.toggle()
//        }
//        else if(indexPath == toTextIndexPath && isfromPlacePickerViewVisible == false){
//            istoPlacePickerViewVisible.toggle()
//        }
//        else if(indexPath == fromTextIndexPath || indexPath == toTextIndexPath){
//            isfromPlacePickerViewVisible.toggle()
//            istoPlacePickerViewVisible.toggle()
//        }
//        else{return}
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seatCount.maximumValue = 4
        
        fromOptions = ["Chitkara University ", "Sector 23 chandigarh", "Rajpura"]
        toOptions = ["Chitkara University ", "Sector 23 chandigarh", "Rajpura"]
        fromPlacePickerView.dataSource = self
        fromPlacePickerView.delegate = self
        toPlacePickerView.dataSource = self
        toPlacePickerView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        fromText.inputView = fromPlacePickerView
        toText.inputView = toPlacePickerView
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        seatCount.maximumValue = 3
//        
//        let fromOptions = ["Chitkara University ", "Sector 23 chandigarh", "Rajpura"]
//           let toOptions = ["Chitkara University ", "Sector 23 chandigarh", "Rajpura"]
//           fromPlacePickerView.dataSource = self
//           fromPlacePickerView.delegate = self
//           toPlacePickerView.dataSource = self
//           toPlacePickerView.delegate = self
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
    
    

   
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        header.textLabel?.frame = CGRect(x: 12, y: 0, width: 300, height: 20)
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
        } else {
            // Code to handle the selection of an item
        }
    }
}

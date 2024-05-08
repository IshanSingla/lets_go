//
//  FindTableViewController.swift
//  lets_go
//
//  Created by Kaushiv on 29/04/24.
//

import UIKit

class FindTableViewController: UITableViewController {

  
    @IBOutlet weak var seatNo: UILabel!
    @IBOutlet weak var seatCount: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        seatCount.maximumValue = 4
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        header.textLabel?.frame = CGRect(x: 12, y: 0, width: 300, height: 20)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        seatNo.text = "\(Int(seatCount.value))"
    }

}

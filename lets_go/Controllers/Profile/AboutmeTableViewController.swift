//
//  AboutmeTableViewController.swift
//  lets_go
//
//  Created by student on 09/05/24.
//

import UIKit

struct AboutMe {
    let name: String
    let rollNo: String
    let mobileNumber: String
    let bio: String
}
class AboutmeTableViewController: UITableViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var universityId: UILabel!
    @IBOutlet weak var year: UILabel!
    
    private var userService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService = AuthService()
        let user = try? userService.getCurrentUser()
        
        name.text = user?.name
        mobileNumber.text = user?.mobileNumber ?? "-"
        universityId.text = user?.rollnumber
        department.text = user?.department
        year.text = user?.year
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

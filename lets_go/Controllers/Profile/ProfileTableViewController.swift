//
//  ProfileTableViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var college: UILabel!
    @IBOutlet weak var year: UILabel!
    
    private var authService: AuthService = AuthService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let user = try authService.getCurrentUser()
            name.text = user.name
            email.text = user.email
            department.text = user.department
            college.text = user.college?.name
            year.text = user.year ?? "2021"
        } catch {
            print("Error: \(error)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
//    i wants function for bar 6th
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            print("Logout")
            do {
                try authService.logout()
                let storyboard = UIStoryboard(name: "AuthApp", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "LoginNC") as! UINavigationController
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                present(vc, animated: true, completion: nil)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

//
//  completeInfoViewController.swift
//  lets_go
//
//  Created by student on 01/05/24.
//

import UIKit
import Foundation

class completeInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
  


    // MARK: - Data Model

    struct User {
        let name: String
        let mobileNumber: String
        let universityID: String
        let department: String
    }

    // MARK: - User Manager

    class UserManager {
        static let shared = UserManager()
        
        private var users: [User] = []
        
        // Add user to the data model
        func addUser(user: User) {
            users.append(user)
        }
        
        // Get all users
        func getAllUsers() -> [User] {
            return users
        }
    }

    // MARK: - View Controller

    class completeInfoViewController: UIViewController {
        @IBOutlet weak var nameTextField: UITextField!
       // @IBOutlet weak var nameTextField: UITextField!
        
        @IBOutlet weak var mobileNumberTextField: UITextField!
        //        @IBOutlet weak var nameTextField: UITextField!
//        @IBOutlet weak var mobileNumberTextField: UITextField!
        @IBOutlet weak var departmentTextField: UITextField!
        @IBOutlet weak var universityIDTextField: UITextField!
//        @IBOutlet weak var universityIDTextField: UITextField!
//        @IBOutlet weak var departmentTextField: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        @IBAction func submitButtonTapped(_ sender: UIButton) {
            
                guard let name = nameTextField.text, !name.isEmpty,
                      let mobileNumber = mobileNumberTextField.text, !mobileNumber.isEmpty,
                      let universityID = universityIDTextField.text, !universityID.isEmpty,
                      let department = departmentTextField.text, !department.isEmpty else {
                    // Show error message if any field is empty
                    showAlert(message: "Please enter all fields.")
                    return

        }
        
       
            
            // Create a new user
            let newUser = User(name: name, mobileNumber: mobileNumber, universityID: universityID, department: department)
            
            // Add the user to the data model
            UserManager.shared.addUser(user: newUser)
            
            // Show success message
            showAlert(message: "User data submitted successfully!")
        }
        
        // Function to show alert message
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Submission", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

   


}

//
//  SignupViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import UIKit
// MARK: - Data Model

struct user {
    let name: String
    let mobileNumber: String
    let universityID: String
    let department: String
    let year: String
}

class UserManager {
    static let shared = UserManager()
    
    private var users: [user] = []
    
    // Add user to the data model
    func addUser(user: user) {
        users.append(user)
    }
    
    // Get all users
    func getAllUsers() -> [user] {
        return users
    }
}

class SignupViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var rollNumber: UITextField!
    @IBOutlet weak var department: UITextField!
    @IBOutlet weak var year: UITextField!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                
                // Set up tap gesture recognizer to dismiss keyboard
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        
    }
    @objc func keyboardWillShow(notification: Notification) {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
        
        // Function to handle keyboard disappearing
        @objc func keyboardWillHide(notification: Notification) {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
        
        // Function to dismiss keyboard when tapping outside of text field
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
   



    @IBAction func submit(_ sender: UIButton) {
        guard let name = name.text, !name.isEmpty,
                      let mobileNumber = mobileNumber.text, !mobileNumber.isEmpty,
                      let universityID = rollNumber.text, !universityID.isEmpty,
                      let department = department.text, !department.isEmpty,
                      let year = year.text, !year.isEmpty else {
                    // Show error message if any field is empty
                    showAlert(message: "Please enter all fields.")
                    return
                }
                
                // Print input data to console
                print("Name: \(name), Mobile Number: \(mobileNumber), University ID: \(universityID), Department: \(department), Year: \(year)")
                
                // Create a new user
                let newUser = user(name: name, mobileNumber: mobileNumber, universityID: universityID, department: department, year: year)
                
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


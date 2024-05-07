//
//  AuthViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

//import UIKit
//
//class AuthViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Hide the back button
//        navigationItem.hidesBackButton = true
//    }
//    
//
//
//}
//
//import UIKit
//
//        class AuthViewController : UIViewController {
//
//            @IBOutlet weak var otpTextField: UITextField!
//            @IBOutlet weak var emailTextField: UITextField!
//           // @IBOutlet weak var emailTextField: UITextField!
//           // @IBOutlet weak var otpTextField: UITextField!
//    
//            
//            @IBAction func signupButtonTapped(_ sender: Any) {
//                guard let email = emailTextField.text, !email.isEmpty,
//                      let otp = otpTextField.text, !otp.isEmpty else {
//                    
//                    showAlert(message: "Please enter both email and OTP.")
//                    return
//                    
//            }
//                func isValidEmail(_ email: String) -> Bool {
//                    let domain = email.components(separatedBy: "@").last ?? ""
//                    return domain.lowercased() == "chitkara.edu.in"
//                }
//                
//              
//                if isValidEmail(email) {
//                    
//                    if otp == "123456" {
//                      
//                        showAlert(message: "Signup successful!")
//                        
//                    } else {
//                       
//                        showAlert(message: "Invalid OTP. Please try again.")
//                    }
//                } else {
//                    
//                    showAlert(message: "Invalid email domain. Please use a chitkara.edu.in email.")
//                }
//            }
//            
//         
//           
//            
//            
//            func showAlert(message: String) {
//                let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(okAction)
//                present(alert, animated: true, completion: nil)
//            }
//        }
// 
//
//
////  
//import UIKit
//
//class SignupViewController: UIViewController {
//
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var otpTextField: UITextField!
//
//    // Function to handle signup button tap
//    @IBAction func signupButtonTapped(_ sender: UIButton) {
//        guard let email = emailTextField.text, !email.isEmpty,
//              let otp = otpTextField.text, !otp.isEmpty else {
//            // Show error message if any field is empty
//            showAlert(message: "Please enter both email and OTP.")
//            return
//        }
//        
//        // Validate email domain
//        if isValidEmail(email) {
//            // Valid email domain
//            // Check if OTP is valid
//            if otp == "123456" {
//                // Valid OTP
//                showAlert(message: "Signup successful!")
//                // Proceed with the segue if both email and OTP are valid
//                performSegue(withIdentifier: "YourSegueIdentifier", sender: nil)
//            } else {
//                // Invalid OTP
//                showAlert(message: "Invalid OTP. Please try again.")
//            }
//        } else {
//            // Invalid email domain
//            showAlert(message: "Invalid email domain. Please use a chitkara.edu.in email.")
//        }
//    }
//    
//    // Function to validate email domain
//    func isValidEmail(_ email: String) -> Bool {
//        let domain = email.components(separatedBy: "@").last ?? ""
//        return domain.lowercased() == "chitkara.edu.in"
//    }
//    
//    // Function to show alert message
//    func showAlert(message: String) {
//        let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
//    
//    // Override shouldPerformSegue to control segue behavior
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        // Check if the segue identifier matches your signup segue
//        if identifier == "YourSegueIdentifier" {
//            // Perform additional validation here if needed
//            // Return false to prevent the segue if conditions are not met
//            return isValidSignup()
//        }
//        // Allow other segues to proceed
//        return true
//    }
    
   

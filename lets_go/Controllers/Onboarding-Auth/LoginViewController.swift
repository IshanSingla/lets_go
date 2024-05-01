//
//  LoginViewController.swift
//  lets_go
//
//  Created by student on 30/04/24.
//

import UIKit

class LoginViewController: UIViewController {
    var isShowing = false
    @IBOutlet weak var confirmEmail: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var otpTextField: UITextField!
    
    @IBOutlet weak var otpButton: UIButton!
    @IBOutlet weak var otpLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        otpLabel.isHidden = true
        otpTextField.isHidden = true
        otpButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmEmailTapped(_ sender: Any) {
        
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your college Email.")
            return
        }
        if !isValidEmail(email) {
            showAlert(message: "Invalid email domain. Please use a chitkara.edu.in email.")
            return
        }
//        emailTextField
//        confirmEmail.
        
        otpLabel.isHidden = false
        otpTextField.isHidden = false
        otpButton.isHidden = false
        return
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let otp = otpTextField.text, !otp.isEmpty else {
            
            showAlert(message: "Please enter Otp OTP.")
            return
    }
        if isValidEmail(email) {
            
            if otp == "123456" {
              
                showAlert(message: "Signup successful!")
                // Proceed with the segue if both email and OTP are valid
                performSegue(withIdentifier: "completeInfoIdentifier", sender: nil)
            } else {
                
                showAlert(message: "Invalid OTP. Please try again.")
            }
        } else {
            
            showAlert(message: "Invalid email domain. Please use a chitkara.edu.in email.")
        }
    }
    
   
    func isValidEmail(_ email: String) -> Bool {
        let domain = email.components(separatedBy: "@").last ?? ""
        return domain.lowercased() == "chitkara.edu.in"
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Signup", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "completeInfoIdentifier" {
            
            return isValidSignup()
        }
        
        return true
    }
    
    func isValidSignup() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty,
              let otp = otpTextField.text, !otp.isEmpty else {
            
            showAlert(message: "Please enter both email and OTP.")
            return false
        }
        
       
        if !isValidEmail(email) {
            
            showAlert(message: "Invalid email domain. Please use a chitkara.edu.in email.")
            return false
        }
        
      
        if otp != "123456" {
            
            showAlert(message: "Invalid OTP. Please try again.")
            return false
        }
        
        
        return true
    }
    
 

}

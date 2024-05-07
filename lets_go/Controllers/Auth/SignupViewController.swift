//
//  SignupViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var rollNumber: UITextField!
    @IBOutlet weak var department: UITextField!
    @IBOutlet weak var year: UITextField!
    
    override func viewDidLoad() {
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
   



    @IBAction func submit(_ sender: Any) {
        
    }
}



import UIKit
// MARK: - Data Model

class SignupViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var rollNumber: UITextField!
    @IBOutlet weak var department: UITextField!
    @IBOutlet weak var year: UITextField!
    var email: String!
    private var user: User!
    
    private var userService: UserService = UserService()
    private var authService: AuthService = AuthService()
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let newuser = try! userService.getUserInfoDuringSignup(email: email ?? "")
        name.text = newuser.name
        mobileNumber.text = newuser.mobileNumber
        rollNumber.text = newuser.rollnumber
        department.text = newuser.department
        year.text = newuser.year
        user = newuser
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
                
        user.name = name
        user.mobileNumber = mobileNumber
        user.rollnumber = universityID
        user.department = department
        user.year = year
        let storyboard = UIStoryboard(name: "AuthorisedApp", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
        try! authService.signupUser(user: user)
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


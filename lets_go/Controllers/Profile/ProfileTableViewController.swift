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
    
    private var authService: AuthService = AuthService()
    private var user: User? {
        didSet {
            name.text = user?.name
            email.text = user?.email
            department.text = user?.department
            college.text = user?.college?.name
        }
    }
    private var userRepository: UserRepository = UserRepository()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            user = try authService.getCurrentUser()
        } catch {
            print("Error: \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                showCollegeDetails()
            }
        }
        if indexPath.section == 1{
            if indexPath.row == 1 {
                showAlertWithTermsOfService()
            }
            else if indexPath.row == 2 {
                showAlertWithPrivacyPolicy()
            }
            else if indexPath.row == 3 {
                showDeveloperDetails()
            }
        }
        else if indexPath.section == 2{
            if indexPath.row == 0 {
                do {
                    try authService.logout()
                    let storyboard = UIStoryboard(name: "AuthApp", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "OnboardingNC") as! UINavigationController
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .coverVertical
                    present(vc, animated: true, completion: nil)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    private func showAlertWithTermsOfService() {
        let termsText = """
        Terms of Service
        
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        2. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        3. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        """
            let alertController = UIAlertController(title: "Terms of Service", message: termsText, preferredStyle: .alert)
            
            let agreeAction = UIAlertAction(title: "Agree", style: .default) { _ in
                // Handle agreement action
                print("User agreed to terms and conditions")
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(agreeAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
    private func showAlertWithPrivacyPolicy() {
        let termsText = """
        Privacy Policy
        
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        2. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        3. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        """
            
            let alertController = UIAlertController(title: "Privacy Policy", message: termsText, preferredStyle: .alert)
            
            let agreeAction = UIAlertAction(title: "Agree", style: .default) { _ in
                // Handle agreement action
                print("User agreed to terms and conditions")
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(agreeAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
    func showDeveloperDetails() {
        var userDetails = ""
        var developers: [User] = userRepository.getDevelopers()
        
        for developer in developers {
            userDetails += """
            
            
            Name: \(developer.name)
            Roll Number: \(developer.rollnumber)
            Email: \(developer.email)
            """
        }
        
        let alertController = UIAlertController(title: "Developer Details", message: userDetails, preferredStyle: .alert)
        
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attributedMessage = NSAttributedString(string: userDetails, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showCollegeDetails() {
        var college = user!.college
        var userDetails = """
        
        Name: \(college!.name ?? "")
        Address: \(college!.address ?? "")
        Website: \(college!.domain ?? "")
        """
        
        let alertController = UIAlertController(title: "College Details", message: userDetails, preferredStyle: .alert)
        
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attributedMessage = NSAttributedString(string: userDetails, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

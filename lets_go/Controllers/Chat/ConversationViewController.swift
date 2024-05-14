//
//  ConversationViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var chat: Chat!
    private var data: [Message]=[]
    private var chatService: ChatService = ChatService()
    private var authService: AuthService = AuthService()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        var message = try? chatService.createMessage(inChat: chat.id, withMessage: textField.text ?? "")
        textField.text = ""
        data.append(message!)
        self.dismissKeyboard()
        tableView.reloadData()
        scrollToBottom(animated: true)
    }
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        self.title = chat.anotherUser?.name
        if let messages = try? chatService.getAllMessages(for: chat.id) {
            data = messages
        }
        self.tableView.backgroundColor = UIColor.systemGray6
        scrollToBottom(animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                
                // Set up tap gesture recognizer to dismiss keyboard
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        
        textField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // Move the text field upwards when the keyboard appears
           animateViewMoving(up: true, moveValue: 250)
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           // Restore the original position when the keyboard disappears
           animateViewMoving(up: false, moveValue: 250)
       }
       
       func animateViewMoving(up: Bool, moveValue: CGFloat) {
           let movementDuration: TimeInterval = 0.3
           let movement: CGFloat = (up ? -moveValue : moveValue)
           
           UIView.beginAnimations("animateView", context: nil)
           UIView.setAnimationBeginsFromCurrentState(true)
           UIView.setAnimationDuration(movementDuration)
           self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
           UIView.commitAnimations()
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    @objc func keyboardWillShow(notification: Notification) {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
        
        // Function to handle keyboard disappearing
        @objc func keyboardWillHide(notification: Notification) {
            tableView.contentInset = .zero
            tableView.scrollIndicatorInsets = .zero
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
        
        // Function to dismiss keyboard when tapping outside of text field
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    func scrollToBottom(animated: Bool) {
        if data.isEmpty {
            return
        } else if data.count < 6 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: animated)
        } else {
            tableView.scrollToRow(at: IndexPath(row: data.count - 1, section: 0), at: .bottom, animated: animated)
        }
    }

        // Implement dynamic cell heights
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let message = data[indexPath.row]
            let estimatedHeight = message.message.height(withConstrainedWidth: tableView.frame.width - 20, font: UIFont.systemFont(ofSize: 17)) + 25 // Add padding
            return estimatedHeight
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = data[indexPath.row]
        let user = try? authService.getCurrentUser()
        let condition = chat.userId == user!.id
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! ConversationTableViewCell
        cell.message.text = chat.message
        cell.message.numberOfLines = 0 // Allow label to wrap multiple lines
        cell.message.font = UIFont.systemFont(ofSize: 17)
//        cell.message.center.x = condition ? 90 : -90
        cell.message.backgroundColor = condition ? UIColor.red.withAlphaComponent(0.65) : UIColor.systemGray4
        cell.message.textColor = condition ? UIColor.white : UIColor.black
        let labelSize = cell.message.sizeThatFits(CGSize(width: tableView.frame.width - 20, height: CGFloat.greatestFiniteMagnitude))
        cell.message.frame = CGRect(
            x: condition ? cell.center.x - 12 : cell.center.x - 188,
            y:  1 , //
            width: 200,
            height: labelSize.height+15)
        return cell
    }
}

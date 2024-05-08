//
//  ConversationViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var chat: Chat!
    
    var data: [Message]=[
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit. lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit. lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "lorem ipsum dolor sit amet consectetur adipiscing elit",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "1",
            message: "Hello",
            createdAt: Date()
        ),
        Message(
            id: "1",
            chatId: "1",
            userId: "2",
            message: "Hello",
            createdAt: Date()
        ),
    ]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
            // Remove extra padding
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        scrollToBottom(animated: false)
        
        self.title = chat.userId2
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                
                // Set up tap gesture recognizer to dismiss keyboard
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
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
    
    func scrollToBottom(animated: Bool) {
            let indexPath = IndexPath(row: data.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
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
        let condition = chat.userId == "1"
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! ConversationTableViewCell
        cell.message.text = chat.message
        cell.message.numberOfLines = 0 // Allow label to wrap multiple lines
        cell.message.font = UIFont.systemFont(ofSize: 17)
//        cell.message.center.x = condition ? 90 : -90
        cell.message.backgroundColor = condition ? UIColor.red.withAlphaComponent(0.65) : UIColor.systemGray4
        cell.message.textColor = condition ? UIColor.white : UIColor.black
//        if condition {
//            cell.message.center.x = cell.center.x + 90
//        } else {
//            cell.message.center.x = cell.center.x - 90
//            
//        }
        // Calculate the height needed for the label based on its content
        let labelSize = cell.message.sizeThatFits(CGSize(width: tableView.frame.width - 20, height: CGFloat.greatestFiniteMagnitude))
        cell.message.frame = CGRect(
            x: condition ? cell.center.x - 12 : cell.center.x - 188,
            y:  1 , //
            width: 200,
            height: labelSize.height+15)
        return cell
        
    }


}

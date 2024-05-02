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
    ]

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        TableView.separatorStyle = .none
        TableView.dataSource = self
        TableView.delegate = self
        self.title = chat.userId2
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! ConversationTableViewCell
        cell.message.text = chat.message
        if chat.userId=="1" {
            cell.message.backgroundColor = UIColor.red
            cell.message.textColor = UIColor.white
//            i wants codinates of cell change and it shift to left side
            cell.message.center.x = cell.center.x + 100
        } else {
            cell.message.backgroundColor = UIColor.lightGray
            cell.message.textColor = UIColor.black
            cell.message.center.x = cell.center.x - 100
        }
        return cell
        
    }


}

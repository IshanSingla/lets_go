//
//  ChatsViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class ChatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TavleView: UITableView!
    var data: [Chat] = [
        Chat(
            id: "1",
            userId1: "1",
            userId2: "User 1",
            createdAt: Date()
        ),
        Chat(
            id: "2",
            userId1: "1",
            userId2: "User 2",
            createdAt: Date()
        ),
        Chat(
            id: "3",
            userId1: "1",
            userId2: "User 3",
            createdAt: Date()
        ),
        Chat(
            id: "4",
            userId1: "1",
            userId2: "User 4",
            createdAt: Date()
        ),
        Chat(
            id: "2",
            userId1: "1",
            userId2: "User 2",
            createdAt: Date()
        ),
        Chat(
            id: "3",
            userId1: "1",
            userId2: "User 3",
            createdAt: Date()
        ),
        Chat(
            id: "4",
            userId1: "1",
            userId2: "User 4",
            createdAt: Date()
        ),
        Chat(
            id: "2",
            userId1: "1",
            userId2: "User 2",
            createdAt: Date()
        ),
        Chat(
            id: "3",
            userId1: "1",
            userId2: "User 3",
            createdAt: Date()
        ),
        Chat(
            id: "4",
            userId1: "1",
            userId2: "User 4",
            createdAt: Date()
        ),

        
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        TavleView.dataSource = self
        TavleView.delegate = self
        // Do any additional setup after loading the view.
    }



    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        cell.username.text = chat.userId2
        cell.dateTime.text = chat.createdAt.description
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ConverzationVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ConversationVC = segue.destination as! ConversationViewController
        ConversationVC.chat = data[(TavleView.indexPathForSelectedRow?.row)!]
        
    }
}

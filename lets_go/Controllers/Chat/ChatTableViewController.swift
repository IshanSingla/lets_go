//
//  ChatTableViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import UIKit

class ChatTableViewController: UITableViewController {
    private var data: [Chat] = [
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        cell.username.text = chat.userId2
        cell.dateTime.text = chat.createdAt.description
//
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ConverzationVC", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let ConversationVC = segue.destination as! ConversationViewController
    //        ConversationVC.chat = data[(TavleView.indexPathForSelectedRow?.row)!]
    //
    //    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

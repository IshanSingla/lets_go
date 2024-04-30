//
//  FindTableViewController.swift
//  lets_go
//
//  Created by student on 29/04/24.
//

import UIKit

class FindTableViewController: UITableViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 2;
        }
        else if section == 1{
            return 1;
        }
        else if section == 2{
            return 1;
        }else if section == 3{
            return 1;
        }
        return 0;
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = CGRect(x: 5, y: 0, width: 300, height: 20)
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  headerView = UIView()
//        let label = UILabel()
//        /*label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textColor = UIColor.black
//        headerView.addSubview(label)*/
//        
//        /*if section != 4 {
//            label.text = "Header\(section + 1)"
//        }else{
//            label.text = ""
//        }*/
//        if section == 0{
//            label.text = "Where are you going:"
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.textColor = UIColor.black
//            headerView.addSubview(label)
//        }
//        else if section == 1{
//            label.text = "When?"
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.textColor = UIColor.black
//            headerView.addSubview(label)
//        }
//        else if section == 2{
//            label.text = "Seats Available?"
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.textColor = UIColor.black
//            headerView.addSubview(label)
//        }else if section == 3{
//            label.text = "Offer Price:"
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.textColor = UIColor.black
//            headerView.addSubview(label)
//        }else if section == 4{
//            label.text = ""
//        }
//        return headerView
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

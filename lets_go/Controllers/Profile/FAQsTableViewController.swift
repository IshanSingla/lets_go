//
//  FAQsTableViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import UIKit

class FAQsTableViewController: UITableViewController {
    
    var faqRepository = FAQRepository()
    var faqs: [FAQ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load FAQs
        faqs = faqRepository.findAll()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return faqs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath)
        
        // Configure the cell...
        let faq = faqs[indexPath.row]
        cell.textLabel?.text = faq.question
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFAQ = faqs[indexPath.row]
        showAlertWithAnswer(selectedFAQ.answer)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func showAlertWithAnswer(_ answer: String) {
        let alertController = UIAlertController(title: "Answer", message: answer, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

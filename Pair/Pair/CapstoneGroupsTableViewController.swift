//
//  CapstoneGroupsTableViewController.swift
//  Pair
//
//  Created by Bradley GIlmore on 5/26/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class CapstoneGroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

     //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
//        let index = Int(arc4random_uniform(UInt32(PersonController.shared.people.count)))
//        let person = PersonController.shared.people[index]

        let person = PersonController.shared.people[indexPath.row]
        cell.textLabel?.text = person.fullName
        
        return cell
    }
    
    func sections() -> Int {
        var sections: Int = 1
        
//        if PersonController.shared.people.count <= 2 {
//            sections = 1
//            self.perGroup = 2
//        } else if PersonController.shared.people.count <= 4 {
//            sections = 2
//        }
        
        if PersonController.shared.people.count / sections > 2 {
            sections += 1
        }
        
        return sections
    }
    
//    func shuffle() -> Person {
//                let index = Int(arc4random_uniform(UInt32(PersonController.shared.people.count)))
//                let person = PersonController.shared.people[index]
//                return person
//    }
    
    //MARK: - IBActions
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        PersonController.shared.shuffle()
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add A Person", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Full Name"
        }
        
        let firstTextField = alert.textFields![0] as UITextField

        let okAction = UIAlertAction(title: "OK", style: .default) { (OKAction) in
            guard let fullName = firstTextField.text else { return }
            
            PersonController.shared.create(fullName: fullName)
            
            self.tableView.reloadData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)

    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    //MARK: - Internal Properties
    
    var perGroup = 0

}

//
//  ViewController.swift
//  Todoey
//
//  Created by Ronner Velazquez on 12/5/18.
//  Copyright © 2018 Ronner Velazquez. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController  {

    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Ron 1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Ron 2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Ron 3"
        itemArray.append(newItem3)
        

        if let items = (defaults.array(forKey: "ToDoListArray") as? [Item]) {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TableView datasources methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

        

    }
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print(textField)
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
    
}


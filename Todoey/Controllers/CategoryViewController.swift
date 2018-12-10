//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ronner Velazquez on 12/8/18.
//  Copyright © 2018 Ronner Velazquez. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

  
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategories()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            print(textField)
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    func saveCategories(){
        do{
            try context.save()
        }catch{
            print("Error saving categories, \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
            
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
}

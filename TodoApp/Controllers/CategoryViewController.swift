//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Nung Shun Chou on 2018-11-05.
//  Copyright © 2018 Nung-Shun Chou. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle:.alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Category"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    //Mark - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    //Mark - Data Manipulation Methods
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
           print("Error on fetching \(error)")
        }
        tableView.reloadData()
    }
    
    func saveCategory() {
        do {
            try context.save()
        }
        catch{
            print("Save error on category \(error)")
        }
        tableView.reloadData()
    }
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    

}

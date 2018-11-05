//
//  ViewController.swift
//  TodoApp
//
//  Created by Nung Shun Chou on 2018-11-02.
//  Copyright © 2018 Nung-Shun Chou. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadItems()
//             if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
    }
    //MARK - Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        return cell
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //deselect when select
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            let content = (UIApplication.shared.delegate) as! AppDelegate.persistentContainer.viewContext
            
            let newItem = Item(context: NSManagedObjectContext)
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()

        }
        alert.addAction(action)

        present(alert,animated: true, completion: nil)
    }
    //MARK - Save item in Items.plist
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error encoding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data =  try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch{
            print("Error while decoding, \(error)")
            }
        }
    }
}


//
//  ViewController.swift
//  Todoey
//
//  Created by Matthew Bailey on 6/30/19.
//  Copyright © 2019 Matthew Bailey. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Title]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Title()
        newItem.title = "Find Mike"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Title()
        newItem2.title = "Find Mike Now"
        itemArray.append(newItem2)
        
        let newItem3 = Title()
        newItem3.title = "Find Mike Again"
        itemArray.append(newItem3)
        
        let newItem4 = Title()
        newItem4.title = "Find Mike Again Please"
        itemArray.append(newItem4)
        
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [Title]{
            itemArray = items
        }
        
        
    }

    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator: value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    //MARK: - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        //print(itemArray[indexPath.row])

    }
    
    //Mark: - Add new items section
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
            //What will happen once the user clicks the add item button on our UIAlert
            print("Success!")
            
            let newItem = Title()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}


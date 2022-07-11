//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Andrey Ramirez on 7/8/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist") }
        if let color = UIColor(hexString: "1D9BF6") {
            let contrastColor = ContrastColorOf(color, returnFlat: true)
            navBar.scrollEdgeAppearance?.largeTitleTextAttributes = [.foregroundColor: contrastColor]
            navBar.scrollEdgeAppearance?.backgroundColor = color
        }
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = categories!.isEmpty ? 1 : categories!.count
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if categories!.isEmpty {
            cell.textLabel?.text = "No categories added"
            cell.backgroundColor = UIColor(hexString: "1D9BF6")
            cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        } else {
            if let category = categories?[indexPath.row] {
                cell.textLabel?.text = category.name

                guard let categoryColor = UIColor(hexString: category.backgroundColor) else {fatalError()}
                cell.backgroundColor = categoryColor
                cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            } else {
                cell.textLabel?.text = "No categories added"
                cell.backgroundColor = UIColor(hexString: "1D9BF6")
                cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
            }
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !categories!.isEmpty {
            performSegue(withIdentifier: K.Segue.goToItems, sender: self)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedCategory = categories?[indexPath.row]
            destinationVC.selectedCategory = selectedCategory
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    // MARK: - Delete data from Swipe
   override func updateModel(at indexPath: IndexPath) {
       if let categoryForDeletion = self.categories?[indexPath.row] {
           let items = categoryForDeletion.items
           do {
               try self.realm.write {
                   self.realm.delete(items) // to not get items be abandoned by parent object
                   self.realm.delete(categoryForDeletion) // delete the category
               }
           } catch {
               print("Error deleting category: \(error)")
           }
       }
   }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: K.Alert.Category.alertTitle, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: K.Alert.Category.addActionTitle, style: .default) { action in
            // what will happen once the user clicks the Add Item button on UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.backgroundColor =  UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
        }
        
        let dismissAction = UIAlertAction(title: K.Alert.cancelActionTitle, style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = K.Alert.Category.textFieldPlaceholder
            textField = alertTextField
        }

        alert.addAction(action)
        // by default, if you use an action with .cancel style, it will show on the left side
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
}

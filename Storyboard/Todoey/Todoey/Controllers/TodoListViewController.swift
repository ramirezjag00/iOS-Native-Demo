//
//  ViewController.swift
//  Todoey
//
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let hexColor = selectedCategory?.backgroundColor {
            title = selectedCategory!.name
            
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist") }
            if let color = UIColor(hexString: hexColor) {
                let contrastColor = ContrastColorOf(color, returnFlat: true)
                navBar.scrollEdgeAppearance?.backgroundColor = color
                navBar.scrollEdgeAppearance?.largeTitleTextAttributes = [.foregroundColor: contrastColor]
                searchBar.barTintColor = color
                searchBar.searchTextField.leftView?.tintColor = contrastColor
            }
        }
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = todoItems!.isEmpty ? 1 : todoItems!.count
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if todoItems!.isEmpty {
            cell.textLabel?.text = "No items added"
        } else {
            if let item = todoItems?[indexPath.row] {
                cell.textLabel?.text = item.title
                cell.accessoryType = item.done ? .checkmark : .none
                
                if let color = UIColor(hexString: selectedCategory!.backgroundColor)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
                    cell.backgroundColor = color
                    cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                    cell.tintColor = item.done ? ContrastColorOf(color, returnFlat: true) : UIColor.systemBlue
                }
            } else {
                cell.textLabel?.text = "No items added"
            }
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !todoItems!.isEmpty {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        // realm.delete(item) // to delete
                        item.done = !item.done // to update
                    }
                } catch {
                    print("Error updating item: \(error)")
                }
            }
            tableView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //MARK: - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: K.Alert.Item.alertTitle, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: K.Alert.Item.addActionTitle, style: .default) { action in
            // what will happen once the user clicks the Add Item button on UIAlert
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving items: \(error)")
                }
                
                self.tableView.reloadData()
            }
        }
        
        let dismissAction = UIAlertAction(title: K.Alert.cancelActionTitle, style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = K.Alert.Item.textFieldPlaceholder
            textField = alertTextField
        }

        alert.addAction(action)
        // by default, if you use an action with .cancel style, it will show on the left side
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting item: \(error)")
            }
        }
    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count != 0 {
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            self.tableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

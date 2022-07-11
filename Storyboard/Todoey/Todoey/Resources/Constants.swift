//
//  Constants.swift
//  Todoey
//
//  Created by Andrey Ramirez on 7/7/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct K {
    static let appName = "Todoey"

    struct Alert {
        static let cancelActionTitle = "Cancel"
        struct Category {
            static let addActionTitle = "Add Category"
            static let alertTitle = "Add New Category"
            static let textFieldPlaceholder = "Create new category"
        }
        
        struct Item {
            static let addActionTitle = "Add Item"
            static let alertTitle = "Add New Todoey Item"
            static let textFieldPlaceholder = "Create new item"
        }
    }

    struct UserDefaultKeys {
        static let todoListArray = "TodoListArray"
    }
    
    struct Segue {
        static let goToItems = "goToItems"
    }
    
    struct TableCells {
        static let swipeableCell = "Cell"
    }
}

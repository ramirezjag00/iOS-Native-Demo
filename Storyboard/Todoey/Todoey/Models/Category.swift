//
//  Category.swift
//  Todoey
//
//  Created by Andrey Ramirez on 7/11/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items: List<Item>
    @Persisted var backgroundColor: String = ""
}

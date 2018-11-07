//
//  Item.swift
//  TodoApp
//
//  Created by Nung Shun Chou on 2018-11-06.
//  Copyright © 2018 Nung-Shun Chou. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items" )
}

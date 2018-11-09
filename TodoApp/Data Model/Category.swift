//
//  Category.swift
//  TodoApp
//
//  Created by Nung Shun Chou on 2018-11-06.
//  Copyright © 2018 Nung-Shun Chou. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backGroundColor: String = ""
    let items = List<Item>()
}

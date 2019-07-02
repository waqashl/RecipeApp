//
//  Model.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 02/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

import Foundation

struct Recipe {
    var title: String
    var description: String
    var imageURL: String = ""
    var calories: Int? = 0
    var tagIds: [String] = []
    var chefId: String?
}

struct Tag {
    var id: String
    var name: String
}

struct Chef {
    var id: String
    var name: String
}


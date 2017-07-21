//
//  Todo.swift
//  Todos
//
//  Created by Mars on 17/07/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import Foundation

class Todo: CustomStringConvertible {
    var id: UInt?
    var title: String
    var completed: Bool
    
    init(id: UInt, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    required init?(json: [String: Any]) {
        guard let todoId = json["id"] as? UInt,
            let title = json["title"] as? String,
            let completed = json["completed"] as? Bool else {
            return nil
        }
        
        self.id = todoId
        self.title = title
        self.completed = completed
    }

    var description: String {
        return "ID: \(self.id ?? 0), " +
                "title: \(self.title), " +
                "completed: \(self.completed)"
    }
}

//
// Created by Mars on 18/07/2017.
// Copyright (c) 2017 Mars. All rights reserved.
//

import Foundation

extension Todo {
    class func list() {
        Alamofire.request(TodoRouter.get(nil))
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }

                guard let todos = response.result.value as? [[String: Any]] else {
                    print("Cannot read the Todo list from the server.")
                    return
                }

                todos.prefix(upTo: 10).reversed().forEach {
                    guard let todo = Todo(json: $0) else {
                        print("Cannot create a todo from the JSON.")
                        return
                    }

                    self.todoList.append(todo)
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
}

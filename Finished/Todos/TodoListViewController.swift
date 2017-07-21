//
//  TodoListViewController.swift
//  Todos
//
//  Created by Mars on 17/07/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import UIKit
import RxSwift

class TodoListViewController: UITableViewController {

    var todoList = [Todo]()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let todoId: Int? = nil
        Observable.of(todoId)
            .map { tid in
                return TodoRouter.get(tid)
            }
            .flatMap { route in
                return Todo.getList(from: route)
            }
            .subscribe(onNext: { (todos: [[String: Any]]) in
                self.todoList = todos.flatMap { Todo(json: $0 ) }
                self.tableView.reloadData()
            }, onError: { error in
                print(error.localizedDescription)
            })
            .addDisposableTo(bag)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo", for: indexPath)

        // Configure the cell...
        let title = todoList[indexPath.row].title
        let attributeString =  NSMutableAttributedString(string: title)

        if todoList[indexPath.row].completed {
            attributeString.addAttribute(NSStrikethroughStyleAttributeName,
                    value: 2, range: NSMakeRange(0, attributeString.length))
        }

        cell.textLabel?.attributedText = attributeString

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

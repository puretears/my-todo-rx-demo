//
// Created by Mars on 18/07/2017.
// Copyright (c) 2017 Mars. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum GetTodoListError: Error {
    case CannotConvertServerResponse
}

extension Todo {
    class func getList(from router: TodoRouter) -> Observable<[[String: Any]]> {
        return Observable.create { (observer) -> Disposable in
            let request = Alamofire.request(router)
                .responseJSON { response in
                    guard response.result.error == nil else {
                        observer.on(.error(response.result.error!))
                        return
                    }

                    guard let todos = response.result.value as? [[String: Any]] else {
                        observer.on(.error(GetTodoListError.CannotConvertServerResponse))
                        return
                    }

                    observer.on(.next(todos))
                    observer.onCompleted()
                }

            return Disposables.create {
                request.cancel()
            }
        }


    }
}
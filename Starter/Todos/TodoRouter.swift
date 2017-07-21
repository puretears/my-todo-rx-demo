//
//  TodoRouter.swift
//  Todos
//
//  Created by Mars on 17/07/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import Foundation
import Alamofire

enum TodoRouter: URLRequestConvertible {
    static let baseURL: String = "https://jsonplaceholder.typicode.com/"
    
    case get(Int?)
    /// TODO: Add other HTTP methods here

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            /// TODO: Add other HTTP methods here
            }
        }
        
        var params: [String: Any]? {
            switch self {
            case .get:
                return nil
            /// TODO: Add other HTTP methods here
            }
        }
        
        var url: URL {
            var relativeUrl: String = "todos"
            
            switch self {
            case .get(let todoId):
                if todoId != nil {
                    relativeUrl = "todos/\(todoId!)"
                }
            /// TODO: Add other HTTP methods here
            }
            
            let url = URL(string: TodoRouter.baseURL)!.appendingPathComponent(relativeUrl)
            
            return url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let encoding = JSONEncoding.default
        
        return try encoding.encode(request, with: params)
    }
}

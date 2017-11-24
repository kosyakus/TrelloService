//
//  Router.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private var besePath: String {
        return "https://api.trello.com"
    }
    
    case getBoards(key: String, token: String)
    
    private var path: String {
        switch self {
        case .getBoards:
            return "/1/members/me/boards"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getBoards:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getBoards(key, token):
            return ["key": key, "token": token]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
        
    }
}

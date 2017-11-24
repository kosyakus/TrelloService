//
//  CardRouter.swift
//  KRTestTask
//
//  Created by Admin on 24.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire

var id = ""

enum CardRouter: URLRequestConvertible {
    
    private var besePath: String {
        return "https://api.trello.com"
    }
    
    case getCards(key: String, token: String)
    
    
    private var path: String {
        switch self {
        case .getCards:
            return "/1/boards/\(id)/cards"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getCards:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getCards(key, token):
            return ["key": key, "token": token]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
        
    }
}

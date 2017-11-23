//
//  BoardService.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import OAuthSwift

class BoardService {
    
    
    var boards = [Board]()
    
    // function for parsing json
    typealias downloadUsersCompletion = () -> Void
    
    func downloadBoards(oauthswift: OAuth1Swift, completion: @escaping (_ success: Bool) -> Void) {
        
        Alamofire.request(Router.getBoards(key: "4be5ef10a4d5a83d6c5d04c5a2f19450", token: oauthswift.client.credential.oauthToken)).responseJSON { response in
            
            switch response.result {
            case .success(let rawJson):
                let json = JSON(rawJson)
                //print(json)
                for  (_, subJson):(String, JSON) in json[] {
                    if  let addBoards = Board(subJson) {
                        self.boards.append(addBoards)
                    }
                }
                
                completion(true)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func showBoard() -> [Board] {
        print(Array(boards))
        return Array(boards)
    }
    
    
    
}

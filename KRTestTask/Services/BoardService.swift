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
    
    let url = "https://api.trello.com/1"
    
    let cardsUrl = "https://api.trello.com/1/boards/id/cards"
    var boards = [Board]()
    
    // function for parsing json
    typealias downloadUsersCompletion = () -> Void
    
    func downloadUsers(completion: @escaping (_ success: Bool) -> Void) {
        
        Alamofire.request(url).responseJSON { response in
            
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
        return Array(boards)
    }
    
    
    
}

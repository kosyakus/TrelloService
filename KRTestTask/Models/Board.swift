//
//  Board.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import SwiftyJSON

class Board {
    
    var boardName: String = ""
    var boardDescription: String = ""
    var boardId: String = ""
    
    convenience init?(_ json: JSON) {
        
        guard
            let boardName = json["name"].string,
            let boardDescription = json["desc"].string,
            let boardId = json["id"].string
            
            else { return nil }
        
        self.init()
        self.boardName = boardName
        self.boardDescription = boardDescription
        self.boardId = boardId
        
    }
    
    
}

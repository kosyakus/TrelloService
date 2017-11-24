//
//  Cards.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import SwiftyJSON

class Cards {
    
    var cardOpenClose: Bool = true
    var cardName: String = ""
    var cardDescription: String = ""
    
    convenience init?(_ json: JSON) {
        
        guard
            let cardOpenClose = json["closed"].bool,
            let cardName = json["name"].string,
            let cardDescription = json["desc"].string
            
            else { return nil }
        
        self.init()
        self.cardOpenClose = cardOpenClose
        self.cardName = cardName
        self.cardDescription = cardDescription
        
    }
    
    
}

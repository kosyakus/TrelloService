//
//  CardService.swift
//  KRTestTask
//
//  Created by Admin on 24.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import OAuthSwift


class CardService {
    
    var cards = [Cards]()
    
    // function for parsing json
    typealias downloadCardsCompletion = () -> Void
    
    func downloadCards(boardId: String, oauthswift: OAuth1Swift, completion: @escaping (_ success: Bool) -> Void) {
        
        id = boardId
        print("ID is \(id)")
        
        Alamofire.request(CardRouter.getCards(key: "4be5ef10a4d5a83d6c5d04c5a2f19450", token: oauthswift.client.credential.oauthToken)).responseJSON { response in
            
            switch response.result {
            case .success(let rawJson):
                let json = JSON(rawJson)
                print(json)
                for  (_, subJson):(String, JSON) in json[] {
                    if  let addCards = Cards(subJson) {
                        self.cards.append(addCards)
                    }
                }
                
                completion(true)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func showCard() -> [Cards] {
        for i in cards {
            print(i.cardName)
        }
        return Array(cards)
    }
    
    
    
}

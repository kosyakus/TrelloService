//
//  ReceiveToken.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import OAuthSwift

class ReceiveToken {

// oauth swift object (retain)
var oauthswift: OAuthSwift?

// MARK: Trello
func doOAuthTrello(viewController: UIViewController) {
    let oauthswift = OAuth1Swift(
        consumerKey:    "4be5ef10a4d5a83d6c5d04c5a2f19450",
        consumerSecret: "0309112d1564ffe3fae8fb59104aa2c5850643f16847a8f8c081aa3e8825fedb",
        requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=KRTestTask",
        authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=KRTestTask",
        accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=KRTestTask"
    )
    
    oauthswift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthswift)
    
    let _ = oauthswift.authorize(
        withCallbackURL: URL(string: "NS.KRTestTask://oauth-callback/trello")!,
        success: { credential, response, parameters in
            //self.showTokenAlert(name: serviceParameters["name"], credential: credential)
            self.testTrello(oauthswift)
            print(credential.oauthToken)
            
            print(credential.oauthTokenSecret)
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)//главный сториборд
            let BoardsTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "BoardsTableViewController")
            viewController.present(BoardsTableViewController, animated: true, completion: nil)
            print("You passed to Boards!")
            
    },
        failure: { error in
            print(error.localizedDescription, terminator: "")
    }
    )
    
}

func testTrello(_ oauthswift: OAuth1Swift) {
    print(oauthswift.client.credential.oauthToken)
    let _ = oauthswift.client.get(
        "https://trello.com/1/members/me/boards",
        success: { response in
            let dataString = response.string!
            print(dataString)
    }, failure: { error in
        print(error)
    }
    )
}
}
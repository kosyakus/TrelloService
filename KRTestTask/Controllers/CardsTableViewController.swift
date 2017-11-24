//
//  CardsTableViewController.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class CardsTableViewController: UITableViewController {
    
    var board: Board?
    var cards = [Cards]()
    let cardService = CardService()
    let recTok = ReceiveToken()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardService.downloadCards(boardId: (board?.boardId)!, oauthswift: oath!, completion: { (success) in
            if success {
                self.cards = self.cardService.showCard()
                print("success")
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)

        let card = cards[indexPath.row]
        //print(card)
        cell.textLabel?.text = "\(card.cardName)"
        if card.cardOpenClose == false {
            cell.detailTextLabel?.text = "The task is open"
        } else {
            cell.detailTextLabel?.text = "The task is closed"
        }

        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "ShowCardDetail" {
     let controller = segue.destination as! CardDetailViewController
     if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
     controller.card = cards[indexPath.row]
     }
     }
    }
    

}

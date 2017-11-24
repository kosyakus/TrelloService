//
//  BoardsTableViewController.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class BoardsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(boards)
    }
    
    
    // in storyboard change the Refresh to "Enabled", refr controll will appear. then connect it to this method
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing() // this line ends the animation
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
        return boards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath)

        let board = boards[indexPath.row]
        print(board.boardName)
        cell.textLabel?.text = "\(board.boardName)"
        cell.detailTextLabel?.text = board.boardDescription
       //}
        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCards" {
            let controller = segue.destination as! CardsTableViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.board = boards[indexPath.row]
            }
        }
    }
    

}

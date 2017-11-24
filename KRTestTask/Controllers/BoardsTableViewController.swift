//
//  BoardsTableViewController.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class BoardsTableViewController: UITableViewController {
    
    //var boards: [Board]?
    //var boards = [Board]()
    //let boardService = BoardService()
    //var oauthswift: OAuth1Swift?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(boards)
        //print(boardService.boards.count)
       /* DispatchQueue.main.async {
            self.boards = self.boardService.showBoard()
            self.tableView.reloadData()
        } */
        
      
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
        // #warning Incomplete implementation, return the number of rows
        //guard boards?.count != 0 else { return 1 }
        //return (boards?.count)!
        //return boardService.boards.count
        return boards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath)

        //if let boards = boards {
        let board = boards[indexPath.row]
        //let board = boardService.boards[indexPath.row]
        print(board.boardName)
        cell.textLabel?.text = "\(board.boardName)"
        cell.detailTextLabel?.text = board.boardDescription
       //}
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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

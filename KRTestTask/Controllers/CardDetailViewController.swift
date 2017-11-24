//
//  CardDetailViewController.swift
//  KRTestTask
//
//  Created by Admin on 23.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    var card: Cards?
    
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if card?.cardOpenClose == true {
            closeLabel.text = "The task is close"
        } else {
            closeLabel.text = "The task is open"
        }
        
        descriptionLabel.text = card?.cardDescription
        nameLabel.text = card?.cardName
            
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

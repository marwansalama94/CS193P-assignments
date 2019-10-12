//
//  ViewController.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cards: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cards.firstIndex(of: sender){
            print("Index \(index)")
        }else{
            print("not found in the collection")
        }
    }
}


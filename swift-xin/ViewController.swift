//
//  ViewController.swift
//  swift-xin
//
//  Created by Dylan Walker Brown on 6/4/14.
//  Copyright (c) 2014 Dylan Walker Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate an IMAP session.
        let session: MCOIMAPSession = MCOIMAPSession()
        NSLog(session.description)
        NSLog("You're thinking of the number: " + thinkinOfANumber.description)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


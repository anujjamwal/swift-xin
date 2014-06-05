//
//  ViewController.swift
//  swift-xin
//
//  Created by Dylan Walker Brown on 6/4/14.
//  Copyright (c) 2014 Dylan Walker Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mailbox: Mailbox!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailbox = Mailbox(owner: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButtonPressed(sender : UIBarButtonItem) {
        self.mailbox.logout()
    }
    
    @IBAction func refreshButtonPressed(sender : UIBarButtonItem) {
        if self.mailbox {
            self.mailbox.fetchInboxMessages()
        }
    }
}


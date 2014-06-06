//
//  ViewController.swift
//  swift-xin
//
//  Created by Dylan Walker Brown on 6/4/14.
//  Copyright (c) 2014 Dylan Walker Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Mailbox Model
    var mailbox: Mailbox?
    
    // Table View
    @IBOutlet var inboxTableView : UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inboxTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "inboxCell")
        mailbox = Mailbox(owner: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func composeButtonPressed(sender : UIBarButtonItem) {
        //let composeViewController = ComposeViewController()
    }
    
    @IBAction func logoutButtonPressed(sender : UIBarButtonItem) {
        mailbox?.logout()
    }
    
    @IBAction func refreshButtonPressed(sender : UIBarButtonItem) {
        mailbox?.fetchInboxMessages()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("Number of emails: \(mailbox?.messages.count)")
        return mailbox!.messages.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("inboxCell") as UITableViewCell
        cell.textLabel.text = mailbox?.messages[indexPath.row].header.subject
        println("Got the subject line: \(mailbox?.messages[indexPath.row].header.subject)")
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


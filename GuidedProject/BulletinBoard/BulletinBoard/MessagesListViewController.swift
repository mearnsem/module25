//
//  MessagesListViewController.swift
//  BulletinBoard
//
//  Created by Emily Mearns on 6/22/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class MessagesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(messagesWereUpdated(_:)), name: MessageController.didRefreshNotification, object: nil)
        
    }
    
    func messagesWereUpdated(notification: NSNotification) {
        tableView.reloadData()
    }
    
    @IBAction func postMessage(sender: UIButton) {
        guard let messageText = textField.text else {return}
        textField.resignFirstResponder()
        textField.text = ""
        let message = Message(message: messageText, date: NSDate())
        MessageController.sharedController.postNewMessage(message)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Delegate/DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.sharedController.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") else {
            return UITableViewCell()
        }
        let messages = MessageController.sharedController.messages
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.message
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(message.date)
        
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 12.0)
        
        return cell
    }
}

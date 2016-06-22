//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Emily Mearns on 6/22/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation

class MessageController {
    
    static let didRefreshNotification = "MessagesControllerDidRefreshNotification"
    
    static let sharedController = MessageController()
    let cloudKitManager = CloudKitManager()
    
    private(set) var messages = [Message]() {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(MessageController.didRefreshNotification, object: self)
            })
        }
    }
    
    init() {
        refresh()
    }
    
    func postNewMessage(message: Message, completion: ((NSError?) -> Void)? = nil) {
        let record = message.cloudKitRecord
        cloudKitManager.saveRecord(record) { (record, error) in
            if let error = error {
                print("Error saving \(message) to CloudKit: \(error)")
                return
            }
            self.messages.append(message)
        }
    }
    
    func refresh(completion: ((NSError?) -> Void)? = nil) {
        cloudKitManager.fetchRecordsWithType(Message.recordType) { (records, error) in
            if let error = error {
                print("Error fetching from CloudKit: \(error)")
                return
            }
            guard let records = records else {return}
            var messages = records.flatMap({Message(cloudKitRecord: $0)})
            messages.sortInPlace {$0.date.compare($1.date) == NSComparisonResult.OrderedDescending}
            self.messages = messages
        }
    }
    
    func subscribeForPushNotifications(completion: ((NSError?) -> Void)? = nil) {
        cloudKitManager.subscribe(Message.recordType, subscriptionID: "MessagesSubcription", contentAvailable: false, alertBody: "There's a new message on the bulletin board", options: .FiresOnRecordCreation) { (subscription, error) in
            if let error = error {
                print("Error saving subscriptions: \(error)")
            }
            completion?(error)
        }
    }
}







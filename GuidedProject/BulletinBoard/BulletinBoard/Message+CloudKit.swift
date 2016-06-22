//
//  Message+CloudKit.swift
//  BulletinBoard
//
//  Created by Emily Mearns on 6/22/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CloudKit

extension Message {
    static let recordType = "Message"
    static let messageTextKey = "MessageText"
    static let dateKey = "Date"
    
    init?(cloudKitRecord: CKRecord) {
        guard let messageText = cloudKitRecord[Message.messageTextKey] as? String, date = cloudKitRecord[Message.dateKey] as? NSDate where cloudKitRecord.recordType == Message.recordType else {return nil}
        
        self.init(message: messageText, date: date)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.recordType)
        record[Message.messageTextKey] = message
        record[Message.dateKey] = date
        return record
    }
}

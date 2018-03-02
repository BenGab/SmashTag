//
//  TwitterUserEntity+CoreDataClass.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 12. 04..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import Foundation
import CoreData
import Twitter


public class TwitterUserEntity: NSManagedObject {
    class func tweetWithTwitterInfo(twitterUserInfo: Twitter.User, in managedObjectContext: NSManagedObjectContext) -> TwitterUserEntity? {
        let request = NSFetchRequest<TwitterUserEntity>(entityName: "TwittUserEntity")
        request.predicate = NSPredicate(format: "screenName = %@", twitterUserInfo.screenName)
        
        if let tweet = (try? managedObjectContext.fetch(request))?.first {
            return tweet
        }
        
        let newUser = TwitterUserEntity()
        newUser.name = twitterUserInfo.name
        newUser.screenName = twitterUserInfo.screenName
        
        managedObjectContext.insert(newUser)
        
        return newUser
    }
}

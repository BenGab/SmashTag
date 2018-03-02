//
//  TweetEntity+CoreDataClass.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 12. 04..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import Foundation
import CoreData
import Twitter


public class TweetEntity: NSManagedObject {
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, in managedObjectContext: NSManagedObjectContext) -> TweetEntity? {
        let request = NSFetchRequest<TweetEntity>(entityName: "TweetEntity")
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
        
        if let tweet = (try? managedObjectContext.fetch(request))?.first {
            return tweet
        }
        
        let newTweet = TweetEntity()
        newTweet.unique = twitterInfo.id
        newTweet.posted = NSDate(timeIntervalSinceNow: twitterInfo.created.timeIntervalSinceNow)
        newTweet.text = twitterInfo.text
        newTweet.cdTweeter = TwitterUserEntity.tweetWithTwitterInfo(twitterUserInfo: twitterInfo.user, in: managedObjectContext)
        
        managedObjectContext.insert(newTweet)
        
        return newTweet
    }
}

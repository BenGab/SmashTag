//
//  TwitterUserEntity+CoreDataProperties.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 12. 04..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import Foundation
import CoreData


extension TwitterUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwitterUserEntity> {
        return NSFetchRequest<TwitterUserEntity>(entityName: "TwitterUserEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var screenName: String?
    @NSManaged public var cdTweets: NSSet?

}

// MARK: Generated accessors for cdTweets
extension TwitterUserEntity {

    @objc(addCdTweetsObject:)
    @NSManaged public func addToCdTweets(_ value: TweetEntity)

    @objc(removeCdTweetsObject:)
    @NSManaged public func removeFromCdTweets(_ value: TweetEntity)

    @objc(addCdTweets:)
    @NSManaged public func addToCdTweets(_ values: NSSet)

    @objc(removeCdTweets:)
    @NSManaged public func removeFromCdTweets(_ values: NSSet)

}

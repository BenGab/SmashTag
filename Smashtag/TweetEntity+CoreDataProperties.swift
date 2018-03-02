//
//  TweetEntity+CoreDataProperties.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 12. 04..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import Foundation
import CoreData


extension TweetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TweetEntity> {
        return NSFetchRequest<TweetEntity>(entityName: "TweetEntity");
    }

    @NSManaged public var posted: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var cdTweeter: TwitterUserEntity?

}

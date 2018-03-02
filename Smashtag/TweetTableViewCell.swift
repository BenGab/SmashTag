//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 11. 13..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    var tweet: Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        tweetScreenNameLabel?.text = nil
        tweetTextLabel?.attributedText = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageUrl = tweet.user.profileImageURL {
                if let imageData = try? Data(contentsOf: profileImageUrl.absoluteURL!) {
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = DateFormatter()
            if Date().timeIntervalSince(tweet.created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: tweet.created)
        }
    }
}

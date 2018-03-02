//
//  ProfileImageTableViewCell.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 11. 27..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import UIKit
import Twitter

class ProfileImageTableViewCell: UITableViewCell {
    var user: User? {
        didSet {
           updateUI()
        }
    }
    
    func updateUI() {
        if let profileImageUrl = user?.profileImageURL {
            if let imageData = try? Data(contentsOf: profileImageUrl.absoluteURL!) {
                profileImage?.image = UIImage(data: imageData)
            }
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
}

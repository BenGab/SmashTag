//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Gábor Benkő on 2016. 11. 27..
//  Copyright © 2016. Gábor Benkő. All rights reserved.
//

import UIKit
import Twitter

class MentionsTableViewController: UITableViewController {
    
    var tweet:  Twitter.Tweet? {
        didSet {
            dataSource.removeAll()
            if let twt = tweet {
                var user = [User]()
                user.insert(twt.user, at: 0)
                dataSource.insert(user, at: 0)
                dataSource.insert(twt.hashtags, at: 1)
                dataSource.insert(twt.urls, at: 2)
                dataSource.insert(twt.userMentions, at: 3)
            }
        }
    }
    
    var selectedMention: Mention? = nil
    
    var dataSource = [[AnyObject]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 300 : 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "Hashtags"
        case 2:
            return "Urls"
        case 3:
            return "Mentions"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = indexPath.section == 0 ? "image" : "hashtag"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let image = cell as? ProfileImageTableViewCell {
            image.user = dataSource[indexPath.section][indexPath.row] as! User
            return image
        }
        
        if let mention = dataSource[indexPath.section][indexPath.row] as? Mention {
            cell.textLabel?.text = mention.keyword
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1, 3:
            selectedMention = dataSource[indexPath.section][indexPath.row] as? Mention
            performSegue(withIdentifier: "retweet", sender: selectedMention)
            break
        case 2:
            if let mention = dataSource[indexPath.section][indexPath.row] as? Mention {
                if let url = URL(string: mention.keyword) {
                    UIApplication.shared.openURL(url)
                }
            }
            break
            
        default:
            return
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TweetTableViewController {
            if let mention = selectedMention {
                vc.searchText = mention.keyword
            }
        }
    }
    
}

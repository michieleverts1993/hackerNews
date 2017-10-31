//
//  MainTableViewExtension.swift
//  hackerNews
//
//  Created by Michiel Everts on 31-10-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation
import UIKit

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row  == newsObjects.count - 1 {
            currentpage += 1
            if currentpage <= HackerNewsService.sharedInstance.totalNumberPages {
                HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage, query: "")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        let selectdNewsItem = newsObjects[indexPath.row]
        cell.TitleLabel.text = selectdNewsItem.story_title
        cell.AuthorLabel.text = selectdNewsItem.author
        cell.TimeStampLabel.text = selectdNewsItem.created_at_i.timepassed()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.newsItem = newsObjects[indexPath.row]
        performSegue(withIdentifier: SegueID.webViewID, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }

}

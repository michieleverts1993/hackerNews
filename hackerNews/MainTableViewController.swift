//
//  MainTableViewController.swift
//  
//
//  Created by Michiel Everts on 27-10-17.
//

import UIKit

class MainTableViewController: UITableViewController {
    var newsObjects: [HackerNewsProperties] = []
    var newsItem: HackerNewsProperties?
    let mainRefreshControl = UIRefreshControl()
    var currentpage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    // make a sharedinstance to your HackerNewService class
        HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage)
    // set up a notification observer to
        NotificationCenter.default.addObserver(self,
                                               selector:
                                                #selector(MainTableViewController.notifyHackerNewsObservers(notification:)),
                                                name: NSNotification.Name(rawValue: NotificationID.getDataID),
                                                object: nil)
        
        let newsNib = UINib(nibName: "DataTableViewCell", bundle: nil)
        self.tableView.register(newsNib, forCellReuseIdentifier: TableCellID.DataTableViewCell)
    }
    @objc func notifyHackerNewsObservers(notification: NSNotification) {
        var newsItemDict = notification.userInfo as! Dictionary<String, AnyObject>
        if let arrayObjects = newsItemDict[KeyID.hackerNewsID] as? [HackerNewsProperties] {
            newsObjects = newsObjects + arrayObjects
            self.tableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsObjects.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row  == newsObjects.count - 1 {
            currentpage += 1
            if currentpage <= HackerNewsService.sharedInstance.totalNumberPages {
                HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage)
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        let selectdNewsItem = newsObjects[indexPath.row]
        cell.TitleLabel.text = selectdNewsItem.story_title
        cell.AuthorLabel.text = selectdNewsItem.author
        cell.TimeStampLabel.text = selectdNewsItem.created_at_i.timepassed()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.newsItem = newsObjects[indexPath.row]
        performSegue(withIdentifier: SegueID.webViewID, sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.webViewID{
            
            let webView = segue.destination as! WebViewController
            webView.cellURL = (newsItem?.story_url)!            
        }
    }
    @objc private func refresh(sender:AnyObject){
        HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage)
        refreshControl?.tintColor = UIColor.lightGray
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if ((indexPath.row % 2) == 1)  {
//            cell.backgroundColor = UIColor.white
//        } else {
//            cell.backgroundColor = UIColor.lightGray
//        }
//    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

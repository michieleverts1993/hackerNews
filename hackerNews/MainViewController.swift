//
//  MainTableViewController.swift
//  
//
//  Created by Michiel Everts on 27-10-17.
//

import UIKit
import SVProgressHUD

class MainTableViewController: UIViewController {
    var newsObjects: [HackerNewsProperties] = []
    var newsItem: HackerNewsProperties?
    let mainRefreshControl = UIRefreshControl()
    var currentpage = 0
    var searchController: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    // make a sharedinstance to your HackerNewService class
        HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage, query: "")
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
            SVProgressHUD.dismiss()
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsObjects.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.webViewID{
            
            let webView = segue.destination as! WebViewController
            webView.cellURL = (newsItem?.story_url)!            
        }
    }
    @objc private func refresh(sender:AnyObject){
        HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage, query: "")
        tableView.refreshControl?.tintColor = UIColor.lightGray
        self.tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

}

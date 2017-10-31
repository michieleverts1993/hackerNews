//
//  SearchBarExtension.swift
//  hackerNews
//
//  Created by Michiel Everts on 31-10-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension MainTableViewController: UISearchBarDelegate{
    
    func setUpSearchBar() {
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        navigationItem.titleView = searchController?.searchBar
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.newsObjects = []
        HackerNewsService.sharedInstance.getTheHackerNews(pages: currentpage, query: searchBar.text!.removeSpecialCharsFromString())
        SVProgressHUD.show()
    }
}

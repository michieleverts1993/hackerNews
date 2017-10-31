//
//  hackerNewsService.swift
//  hackerNews
//
//  Created by Michiel Everts on 27-10-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation
import Alamofire

class HackerNewsService {
    var totalNumberPages = 1
    public static let sharedInstance = HackerNewsService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    func getTheHackerNews(pages: Int) {
        print("https://hn.algolia.com/api/v1/search_by_date?query=creepypasta&page=\(pages)")
        Alamofire.request("https://hn.algolia.com/api/v1/search_by_date?query=creepypasta&page=\(pages)").responseJSON { (jsonData)
            in
            print(jsonData)
            // var Array of classobjects/properties
            var itemArray:[HackerNewsProperties] = []
            // gettting the jsonData from the server and opening it as an NSDict (json is always Dict first)
            if let json = jsonData.result.value as? NSDictionary,
            // make a var in wich u store the array stored in de Dict, and optionally open it as NSArray
                let hits = json["hits"] as? NSArray,
                let pages = json["nbPages"] as? Int{
                self.totalNumberPages = pages
            // make a "for loop" to loop through the array to search for the dict's in the array and store every dict as an object in unwrappedDict (per 1)
                for dict in hits {
                    if let unwrappedDict = dict as? NSDictionary {
                        print(unwrappedDict)
            // making a constant for every key u wanna loop around in the array od dicts
                      if let story_title = unwrappedDict["story_title"] as? String,
                        let author = unwrappedDict["author"] as? String,
                        let created_at_i = unwrappedDict["created_at_i"] as? Double,
                        let story_url = unwrappedDict["story_url"] as? String{
            // init all the constants
                        let hackerNews = HackerNewsProperties.init(story_title: story_title,
                                                                        author: author,
                                                                        created_at_i: created_at_i,
                                                                        story_url: story_url)
            // append every HackerNewsProperties object to the array
                        itemArray.append(hackerNews)
                        }
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationID.getDataID),
                                                object: self,
                                                userInfo: [KeyID.hackerNewsID : itemArray])
            }
        }
    }

}

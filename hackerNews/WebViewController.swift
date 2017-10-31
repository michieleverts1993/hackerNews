//
//  WebViewController.swift
//  
//
//  Created by Michiel Everts on 30-10-17.
//

import UIKit
import WebKit
import SVProgressHUD


class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var WebViewoutlet: WKWebView!
    var cellURL = ""
    var selectedNewsItem: HackerNewsProperties?
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let myUrl = URL(string: cellURL)
        let requestObject = URLRequest(url: myUrl!)
        self.WebViewoutlet.navigationDelegate = self
        WebViewoutlet.load(requestObject)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  ViewController.swift
//  WaybackBrowser
//
//  Created by Liam Dowd on 6/14/22.
//

import Cocoa
import WebKit
import PythonKit
import SwiftExec


class ViewController: NSViewController, WKUIDelegate, WKNavigationDelegate, NSTextFieldDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var searchBar: NSTextField!
    @IBOutlet var forward: NSButton!
    @IBOutlet var back: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        let url = URL(string: "http://127.0.0.1:5000/home")
        let request = URLRequest(url: url!)
        webView.load(request)
        self.searchBar.stringValue = "https://google.com"
        //self.searchBar.delegate = self
    }

    @IBAction func back(_ sender: Any) {
        webView?.goBack()
    }
    
    @IBAction func foward(_ sender: Any) {
        webView?.goForward()
    }
    
    @IBAction func textFieldAction(sender: NSTextField) {
        print(sender.stringValue)
        print("RETURNED")
        var urlstr = "http://127.0.0.1:5000/loadpage?url=" + self.searchBar.stringValue + "&year=2001&month=10&day=10"
        let url = URL(string: urlstr)
        let request = URLRequest(url: url!)
        webView.load(request)
        //self.searchBar.stringValue = "https://google.com"
    }
}

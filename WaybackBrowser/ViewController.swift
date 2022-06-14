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
        let url = Bundle.main.url(forResource: "home", withExtension: "html")
        let request = URLRequest(url: url!)
        webView.load(request)
        self.searchBar.stringValue = "https://google.com"
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
        do{
            guard let filePath = Bundle.main.path(forResource: "loadpage", ofType: "html") else { return }
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        } catch {
            print("HTML File error")
        }
        //var urlstr = "http://127.0.0.1:5000/loadpage?url=" + self.searchBar.stringValue + "&year=2001&month=10&day=10"
        //let url = URL(string: urlstr)
        //let request = URLRequest(url: url!)
        //webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("HERE123")
        //var urlstr = "http://127.0.0.1:5000/loadpage?url=" + self.searchBar.stringValue + "&year=2001&month=10&day=10"
        print(self.searchBar.stringValue)
        var urlstr = "https://web.archive.org/web/" + "2001" + "10" + "10" + "043326if_/" + self.searchBar.stringValue
       print(urlstr)
       var jsscript = "populate(\"" + urlstr + "\")"
        //"populate(" + urlstr + ")"
       webView.evaluateJavaScript(jsscript, completionHandler: nil)
    }
    
}

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
    @IBOutlet var datePicker: NSDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        let url = Bundle.main.url(forResource: "home", withExtension: "html")
        let request = URLRequest(url: url!)
        webView.load(request)
        self.searchBar.stringValue = "https://google.com"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "YYYY/MM/dd"
        let date = dateFormatter.date(from: "2000/1/1")
        datePicker.dateValue = date!
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
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var date = datePicker.dateValue
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        var datestr = dateFormatter.string(from: date)
        var datesplit = datestr.split(separator: "/").map(String.init)
        print(datesplit)
        print(self.searchBar.stringValue)
        var urlstr = "https://web.archive.org/web/" + datesplit[0] + datesplit[1] + datesplit[2] + "043326if_/" + self.searchBar.stringValue
       print(urlstr)
       var jsscript = "populate(\"" + urlstr + "\")"
       webView.evaluateJavaScript(jsscript, completionHandler: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: NSDatePicker) {
        do{
            guard let filePath = Bundle.main.path(forResource: "loadpage", ofType: "html") else { return }
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        } catch {
            print("HTML File error")
        }
    }
    
}

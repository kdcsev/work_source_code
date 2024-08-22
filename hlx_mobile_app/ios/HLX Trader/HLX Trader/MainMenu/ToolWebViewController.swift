//
//  ToolWebViewController.swift
//  HLX Trader
//

import UIKit
import WebKit

class ToolWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var htmlFile = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        if let htmlPath = Bundle.main.path(forResource: self.htmlFile, ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url:url)
            self.webView.load(request)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        APICall.hideHUD()
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension ToolWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        APICall.showHUD()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        APICall.hideHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        APICall.hideHUD()
    }
}

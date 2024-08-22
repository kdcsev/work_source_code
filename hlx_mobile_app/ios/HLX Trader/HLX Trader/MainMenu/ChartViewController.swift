//
//  ChartViewController.swift
//  HLX Trader
//

import UIKit
import WebKit

class ChartViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        if let htmlPath = Bundle.main.path(forResource: "live_chart", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url:url)
            self.webView.load(request)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        APICall.hideHUD()
    }
}


extension ChartViewController: WKNavigationDelegate {
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

//
//  HelpJoinGroupCell.swift
//

import UIKit
import WebKit

class HelpJoinGroupCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.videoView.navigationDelegate = self
        self.videoView.scrollView.isScrollEnabled = false
        
        let htmlString = Constants.videoHtml.replacingOccurrences(of: "{video_id}", with: Constants.helpVideoIds[1])
        self.videoView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func onActionStartedClicked(_ sender: UIButton) {
        let application = UIApplication.shared
        if let url = URL(string: URLs.REGISTER_URL), application.canOpenURL(url) {
            application.open(url)
        }
    }
}

extension HelpJoinGroupCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loadingView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingView.stopAnimating()
    }
}

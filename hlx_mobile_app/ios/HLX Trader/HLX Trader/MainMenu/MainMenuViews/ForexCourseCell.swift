//
//  ForexCourseCell.swift
//

import UIKit
import WebKit

class ForexCourseCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var isAdvanced = false
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var videoInex : Int? {
        didSet {
            guard let index = self.videoInex else {
                return
            }
            
            if self.isAdvanced {
                self.titleLabel.text = Constants.advancedVideoTitles[index]
            } else {
                self.titleLabel.text = Constants.videoTitles[index]
            }
            
            self.videoView.navigationDelegate = self
            self.videoView.scrollView.isScrollEnabled = false
            //self.videoView.layer.borderWidth = 1
            //self.videoView.layer.borderColor = UIColor.lightGray.cgColor
            
            var videoId = ""
            if isAdvanced {
                videoId = Constants.advancedVideoIds[index]
            } else {
                videoId = Constants.videoIds[index]
            }
            
            if videoId.count > 0 {
                let htmlString = Constants.videoHtml.replacingOccurrences(of: "{video_id}", with: videoId)
                self.videoView.loadHTMLString(htmlString, baseURL: nil)
            }
        }
    }
}

extension ForexCourseCell: WKNavigationDelegate {
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

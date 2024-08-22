//
//  ForexCourseViewController.swift
//  HLX Trader
//

import UIKit
import WebKit

class ForexCourseViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var basicLabel: UILabel!
    
    var isAdvanced = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAdvanced {
            self.titleLabel.text = "Welcome to the Advanced HLX Academy!"
            self.basicLabel.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension ForexCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isAdvanced {
            return Constants.advancedVideoTitles.count
        } else {
            return Constants.videoTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForexCourseCell") as! ForexCourseCell
        /*let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = Constants.videoTitles[indexPath.row]
        //let thumbnailImage = cell.viewWithTag(2) as! UIImageView
        //thumbnailImage.sd_setImage(with: URL(string: Constants.videoLinks[indexPath.row]))
        let videoView = cell.viewWithTag(3) as! WKWebView
        videoView.scrollView.isScrollEnabled = false
        let htmlpath = Bundle.main.path(forResource: "video1", ofType: "html")
        let url = URL(fileURLWithPath: htmlpath!)
        let request = URLRequest(url:url)
        videoView.load(request)*/
        cell.isAdvanced = self.isAdvanced
        cell.videoInex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

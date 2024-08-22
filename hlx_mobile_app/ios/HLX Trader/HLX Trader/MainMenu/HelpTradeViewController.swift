//
//  HelpTradeViewController.swift
//  HLX Trader
//

import UIKit

class HelpTradeViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(HelpTradeCell.self, forCellReuseIdentifier: "HelpTradeCell")
        self.tableView.register(HelpJoinGroupCell.self, forCellReuseIdentifier: "HelpJoinGroupCell")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func onActionStartedClicked(_ sender: UIButton) {
        if let url = URL(string: URLs.REGISTER_URL) {
            //openWebUrl(self, url: url)
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func onActionFacebookGroupUrl() {
        openWebUrl(self, url: URLs.FACEBOOK_GROUP_URL)
    }
}

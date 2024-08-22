//
//  HomeViewController.swift
//  HLX Trader
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let hyperAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: self.startedButton.titleColor(for: .normal)!, .underlineStyle: NSUnderlineStyle.single.rawValue]
        //let attributeString = NSMutableAttributedString(string: self.startedButton.currentTitle!, attributes: hyperAttributes)
        //self.startedButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let tabBarController = self.tabBarController as! MainTabBarController
        //tabBarController.transparentNavigationBar()
    }
    
    @IBAction func onActionFacebookClicked(_ sender: UIButton) {
        openSocialApp(self, type: SOCIAL_LOGIN_ENUM.Facebook)
    }
    
    @IBAction func onActionInstagramClicked(_ sender: UIButton) {
        openSocialApp(self, type: SOCIAL_LOGIN_ENUM.Instagram)
    }
    
    @IBAction func onActionTelegramClicked(_ sender: UIButton) {
        openSocialApp(self, type: SOCIAL_LOGIN_ENUM.Telegram)
    }
    
    @IBAction func onActionStartedClicked(_ sender: UIButton) {
        if let url = URL(string: URLs.REGISTER_URL) {
            //openWebUrl(self, url: url)
            UIApplication.shared.open(url)
        }
    }
}

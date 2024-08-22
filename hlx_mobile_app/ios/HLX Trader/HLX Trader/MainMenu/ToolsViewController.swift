//
//  ToolsViewController.swift
//  HLX Trader

import UIKit

class ToolsViewController: UIViewController {
    
    @IBOutlet weak var advancedButton: UIButton!
    @IBOutlet weak var premiumImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*if Config.isUserLoggedIn {
            Config.callCheckDeviceMethod(self)
        } else {
            self.initView()
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let webToolVC = segue.destination as? ToolWebViewController {
            if segue.identifier == "showPipSizeCalculator" {
                webToolVC.htmlFile = "pip_size_calculator"
                webToolVC.navigationItem.title = "Pip Size Calculator"
            } else if segue.identifier == "showPositionSizeCalculator" {
                webToolVC.htmlFile = "position_size_calculator"
                webToolVC.navigationItem.title = "Position Size Calculator"
            } else if (segue.identifier == "showNewsCalendar") {
                webToolVC.htmlFile = "news_calendar"
                webToolVC.navigationItem.title = "News Calendar"
            } else {
                
            }
        } else if let forexCourseVC = segue.destination as? ForexCourseViewController {
            if segue.identifier == "showAdvancedForexCourse" {
                //if Config.isUserLoggedIn {
                    forexCourseVC.navigationItem.title = "Advanced Forex Course"
                    forexCourseVC.isAdvanced = true
                //} else {
                //    self.showMessage("Please Login to Access this Feature!")
                //}
            }
        }
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func initView() {
        if Config.isUserLoggedIn {
            self.premiumImageView.image = #imageLiteral(resourceName: "ic_unlocked")
        } else {
            self.premiumImageView.image = #imageLiteral(resourceName: "ic_premium")
        }
    }
    
    func callCheckDeviceMethod() {
        APICall.checkDevice() { result in
            APICall.hideHUD()
            if result {
                Config.logout()
                self.showMessage("Your session has expired. Please login to access premium content!")
            }
            self.initView()
        }
    }
}

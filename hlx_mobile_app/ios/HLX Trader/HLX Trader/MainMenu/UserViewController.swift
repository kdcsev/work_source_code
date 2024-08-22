//
//  UserViewController.swift
//  HLX Trader

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var logoutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.emailTextField.text = "JBaker"
        //self.pwdTextField.text = "123456"
        
        //self.emailTextField.text = "obsessed4c"
        //self.pwdTextField.text = "123"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Config.isUserLoggedIn {
            Config.callCheckDeviceMethod(self)
        }/* else {
            self.loginView.alpha = 1
            self.logoutView.alpha = 0
        }*/
    }
    
    @IBAction func onActionLogoutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func logout() {
        APICall.logout() { result in
            APICall.hideHUD(result, 0.5)
            if result {
                APICall.afterDelay(0.5, {
                    Config.logout()
                    //self.updateViewStatus(false)
                    Config.openLoginVC()
                })
            } else {
                APICall.afterDelay(0.5, {
                    self.showMessage(message: "Logout failed! Please try again.")
                })
            }
        }
    }
    
    func showMessage(_ title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func callCheckDeviceMethod() {
        APICall.checkDevice() { result in
            APICall.hideHUD()
            if result {
                Config.logout()
                self.showMessage(message: "Your session has expired. Please login to access premium content!")
            }
            self.updateViewStatus(Config.isUserLoggedIn, duration: 0)
        }
    }
    
    @IBAction func onActionLoginClicked(_ sender: UIButton) {
        //UIApplication.shared.open(URL(string: "https://higherlevelfx.com")!)
        //if let url = URL(string: URLs.LOGIN_URL) {
        //    openWebUrl(self, url: url)
        //}
        
        self.view.endEditing(true)
        let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.pwdTextField.text!
        if email.count == 0 {
            APICall.showHUD("Please input vaild Email or Username.")
        } else if password.count == 0 {
            APICall.showHUD("Please input vaild Password.")
        } else {
            self.callLoginMethod(email, password: password)
        }
    }
    
    @IBAction func onActionForgotClicked(_ sender: UIButton) {
        //UIApplication.shared.open(URL(string: "https://higherlevelfx.com")!)
        if let url = URL(string: URLs.FORGOT_URL) {
            openWebUrl(self, url: url)
        }
    }
    
    func updateViewStatus(_ isLoggedIn: Bool, duration:TimeInterval = 0.5) {
        UIView.animate(withDuration: duration) {
            if isLoggedIn {
                self.loginView.alpha = 0
                self.logoutView.alpha = 1
            } else {
                self.loginView.alpha = 1
                self.logoutView.alpha = 0
            }
        }
    }
    
    func callLoginMethod(_ email: String, password: String) {
        Config.logout()
        APICall.login(email, password: password, completion: { (result, response) in
            APICall.hideHUD(result, 0.5)
            if result {
                Config.saveObject(email, key: Constants.USER_EMAIL)
                Config.saveObject(password, key: Constants.USER_PASS)
                if let token = response, token.count > 0 {
                    Config.saveObject(token, key: Constants.USER_TOKEN)
                }
                APICall.afterDelay(0.5, {
                    self.updateViewStatus(true)
                    self.showMessage("You're in!", message: "Now you have full access to all HLX Trade Ideas and Servers.")
                })
            } else {
                if let reason = response, reason == "invalid_token" {
                    APICall.afterDelay(0.5, {
                        self.showMessage(message: "It seems like you're logged in on another device, in order to login please logout from the other device and try again.")
                    })
                } else {
                    APICall.afterDelay(0.5, {
                        self.showMessage("Incorrect credentials or inactive user!", message: "Please login with the same credentials that you used when registering to HLX.")
                    })
                }
            }
        })
    }
}

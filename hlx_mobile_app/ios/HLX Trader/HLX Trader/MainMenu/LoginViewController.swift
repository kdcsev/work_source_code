//
//  LoginViewController.swift
//  HLX Trader

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                Constants.PUSH_TOKEN = token
            }
        }
        
        //self.emailTextField.text = "quanseng"
        //self.pwdTextField.text = "123456"
        
        //self.emailTextField.text = "obsessed4c"
        //self.pwdTextField.text = "123"
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
                    //self.showMessage("You're in!", message: "Now you have full access to all HLX Trade Ideas and Servers.")
                    self.openMainVC()
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
    
    func showMessage(_ title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func openMainVC() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainNavigationVC")
        //controller.modalTransitionStyle = .flipHorizontal
        //self.present(controller, animated: true, completion: nil)
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDel.window else {
            return
        }
        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
}

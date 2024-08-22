//
//  API.swift
//  webservicesDemo
//
//  Created by Ahmed Elzohry on 1/31/17.
//  Copyright © 2017 Ahmed Elzohry. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class APICall: NSObject {
    class func showHUD () {
        //SVProgressHUD.show(withStatus: "Loading...")
        SVProgressHUD.show()
    }
    
    class func showHUD (status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showHUD(_ message: String) {
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    class func hideHUD() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
    
    class func isShowingHUD() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    class func hideHUD(_ success: Bool, _ delay: TimeInterval = 2) {
        if success {
            SVProgressHUD.showSuccess(withStatus: "Success!")
        } else {
            SVProgressHUD.showError(withStatus: "Failed!")
        }
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    class func afterDelay(_ delay: Double, _ closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    /*class func login(_ email: String, password: String, completion: @escaping (_ result: Bool) -> Void) {
        showHUD()
        let parameters = [
            Constants.USER_NAME: email,
            Constants.USER_PASSWORD: password
            ] as [String : Any]
        
        AF.request(URLs.LOGIN_API_URL, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .response { response in
                if response.response?.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }*/
    
    
    class func checkToken(_ completion: @escaping (_ result: Bool) -> Void) {
        showHUD()
        AF.request(URLs.CHECK_TOKEN_URL, method: .get, encoding: JSONEncoding.default, headers: Config.AUTH_HEADER)
            .responseString { response in
                if response.response?.statusCode == 403 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func login(_ email: String, password: String, completion: @escaping (_ result: Bool, _ response: String?) -> Void) {
        showHUD()
        let parameters = [
            Constants.USERNAME: email,
            Constants.PASSWORD: password,
            Constants.FCM_TOKEN: Constants.PUSH_TOKEN,
            Constants.DEVICE_TOKEN: UUID().uuidString
            ] as [String : Any]
        
        AF.request(URLs.LOGIN_API_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                if response.response?.statusCode == 200 {
                    switch response.result {
                    case .failure(let error):
                        print(error)
                        completion(false, nil)
                        break
                    case .success(let value):
                        completion(true, value)
                        break
                    }
                } else if response.response?.statusCode == 409 {
                    completion(false, "invalid_token")
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func logout(_ completion: @escaping (_ result: Bool) -> Void) {
        showHUD()
        AF.request(URLs.LOGOUT_API_URL, method: .delete, encoding: JSONEncoding.default, headers: Config.AUTH_HEADER)
            .response { response in
                if response.response?.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func getNotification(_ completion: @escaping (_ result: Bool, _ level: String?) -> Void) {
        AF.request(URLs.NOTIFICATION_URL + "?fcmToken=\(Constants.PUSH_TOKEN)", method: .get, encoding: JSONEncoding.default)
            .responseString { response in
                if response.response?.statusCode == 200 {
                    switch response.result {
                    case .failure(let error):
                        print(error)
                        completion(false, nil)
                        break
                    case .success(let value):
                        completion(true, value)
                        break
                    }
                } else if response.response?.statusCode == 403 {
                    completion(false, "invalid_token")
                } else if response.response?.statusCode == 404 {
                    completion(false, "invalid_level")
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func postNotification(_ level: String, completion: @escaping (_ result: Bool) -> Void) {
        showHUD()
        let parameters = [
            Constants.FCM_TOKEN: Constants.PUSH_TOKEN,
            Constants.LEVEL: level
            ] as [String : Any]
        
        AF.request(URLs.NOTIFICATION_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                if response.response?.statusCode == 403 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func deleteNotification(_ completion: @escaping (_ result: Bool) -> Void) {
        showHUD()
        AF.request(URLs.NOTIFICATION_URL + "?fcmToken=\(Constants.PUSH_TOKEN)", method: .delete, encoding: JSONEncoding.default)
            .response { response in
                if response.response?.statusCode == 403 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func checkDevice(_ completion: @escaping (_ result: Bool) -> Void) {
        //showHUD()
        AF.request(URLs.CHECK_DEVICE_URL, method: .get, encoding: JSONEncoding.default, headers: Config.AUTH_HEADER)
            .responseString { response in
                if response.response?.statusCode == 403 {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
}

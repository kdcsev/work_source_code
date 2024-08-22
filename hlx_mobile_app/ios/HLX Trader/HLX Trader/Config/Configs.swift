//
//  Configs.swift
//  ForeLong
//
//  Created by PingPong on 4/13/20.
//  Copyright © 2020 PingPong. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let mainTitleArray = ["Profile", "Matches", "Store", "Social", "Games", "About"]

let mainImageArray = [#imageLiteral(resourceName: "ic_profile"), #imageLiteral(resourceName: "ic_matches"), #imageLiteral(resourceName: "ic_welcome"), #imageLiteral(resourceName: "ic_social"), #imageLiteral(resourceName: "ic_games"), #imageLiteral(resourceName: "ic_about")]

let colorsArray = [
    UIColor(red: 237.0/255.0, green: 85.0/255.0, blue: 100.0/255.0, alpha: 1.0),    // HATS category
    UIColor(red: 250.0/255.0, green: 110.0/255.0, blue: 82.0/255.0, alpha: 1.0),    // BAGS category
    UIColor(red: 255.0/255.0, green: 207.0/255.0, blue: 85.0/255.0, alpha: 1.0),    // EYEWEAR category
    UIColor(red: 160.0/255.0, green: 212.0/255.0, blue: 104.0/255.0, alpha: 1.0),   // T-SHIRTS category
    UIColor(red: 72.0/255.0, green: 207.0/255.0, blue: 174.0/255.0, alpha: 1.0),    // SHOES category
    UIColor(red: 79.0/255.0, green: 192.0/255.0, blue: 232.0/255.0, alpha: 1.0),    // JEWELS category
    UIColor(red: 93.0/255.0, green: 155.0/255.0, blue: 236.0/255.0, alpha: 1.0),
    UIColor(red: 172.0/255.0, green: 146.0/255.0, blue: 237.0/255.0, alpha: 1.0),
    UIColor(red: 150.0/255.0, green: 123.0/255.0, blue: 220.0/255.0, alpha: 1.0),
    UIColor(red: 236.0/255.0, green: 136.0/255.0, blue: 192.0/255.0, alpha: 1.0),
    UIColor(red: 218.0/255.0, green: 69.0/255.0, blue: 83.0/255.0, alpha: 1.0),
    UIColor(red: 246.0/255.0, green: 247.0/255.0, blue: 251.0/255.0, alpha: 1.0),
    UIColor(red: 230.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0),
    UIColor(red: 204.0/255.0, green: 208.0/255.0, blue: 217.0/255.0, alpha: 1.0),
    UIColor(red: 67.0/255.0, green: 74.0/255.0, blue: 84.0/255.0, alpha: 1.0),
    UIColor(red: 198.0/255.0, green: 156.0/255.0, blue: 109.0/255.0, alpha: 1.0),
    UIColor(red: 72.0/255.0, green: 207.0/255.0, blue: 174.0/255.0, alpha: 1.0)
]

enum DataType : Int {
    case Dashboard = 0
    case History = 1
}

struct URLs {
    
    static let API_URL = "http://hlx-mobile-api.com/"//"http://test.hlx-mobile-api.com/"//
    
    static let SITE_URL = "https://higherlevelfx.com/"
    static let REGISTER_URL = SITE_URL + "home/register"
    static let LOGIN_URL = SITE_URL + "home/login"
    static let FORGOT_URL = SITE_URL + "home/reset_password"
    
    //static let LOGIN_API_URL = SITE_URL + "mobile/main/check_user"
    static let LOGIN_API_URL = API_URL + "login"
    static let LOGOUT_API_URL = API_URL + "logout"
    static let CHECK_TOKEN_URL = API_URL + "check-token"
    static let CHECK_DEVICE_URL = API_URL + "check-device"
    static let NOTIFICATION_URL = API_URL + "notification"
    
    static let TRADE_WEBSOCKET_URL = "ws://hlx-mobile-api.com/data-stream"//"ws://test.hlx-mobile-api.com/data-stream?token="
    
    static let INSTAGRAM_APPURL = URL(string: "instagram://user?username=higherlevelfx")
    static let INSTAGRAM_WEBURL = URL(string: "https://www.instagram.com/higherlevelfx")
    
    static let TWITTER_APPURL =  URL(string: "twitter://user?screen_name=higherlevelfx")
    static let TWITTER_WEBURL =  URL(string: "https://twitter.com/higherlevelfx")
    
    static let FACEBOOK_APPURL =  URL(string: "fb://profile?id=higherlevelfx")
    static let FACEBOOK_WEBURL =  URL(string: "https://www.facebook.com/higherlevelfx")
    
    static let FACEBOOK_GROUP_URL =  URL(string: "https://www.facebook.com/groups/thefreedomsocietygroup")!
    
    static let TELEGRAM_WEBURL =  URL(string: "https://t.me/higherlevelfx")
    static let TELEGRAM_APPURL =  URL(string: "tg://resolve?domain=higherlevelfx")//URL(string: "tg://join?invite=higherlevelfx")
}

struct Constants {
    
    static let USER_NAME = "user_name"
    static let USER_PASSWORD = "user_password"
    
    static let USERNAME = "username"
    static let PASSWORD = "password"
    static let FCM_TOKEN = "fcmToken"
    static let DEVICE_TOKEN = "deviceToken"
    static let LEVEL = "level"
    
    
    static let USER_INFO = "USER_INFO"
    static let USER_EMAIL = "USER_EMAIL"
    static let USER_PASS = "USER_PASS"
    static let USER_LOGGEDIN = "USER_LOGGEDIN"
    static let USER_TOKEN = "USER_TOKEN"
    
    static let NOTIFICATION_ON = "NOTIFICATION_ON"
    
    static var PUSH_TOKEN = "ios"
    
    static var videoHtml = "<head><meta name='viewport' content='width=device-width, initial-scale=0.8, maximum-scale=0.8, minimum-scale=0.8, user-scalable=no'></head><iframe src='https://player.vimeo.com/video/{video_id}' width='100%' height='100%' frameborder='0' allow='autoplay; fullscreen' allowfullscreen></iframe>"
    
    static let videoTitles = ["Forex Lifestyle",
                       "Introduction to Forex",
                       "Basic Terminology",
                       "How to Use Meta Trader 4",
                       "Placing a Trade",
                       "Lot Size and Pips",
                       "Risk Management",
                       "Higher Impact Events",
                       "CandleStick Patterns",
                       "Identifying Trendlines",
                       "Support and Resistance",
                       "Sentiment",
                       "Market Levels",
                       "Indicators and How I Use Them",
                       "Backtesting",
                       "My Strategy from Start to Finish (part 1)",
                       "My Strategy from Start to Finish (part 2)"]
    
    static let videoIds = ["394771909",
                      "394712319",
                      "394712633",
                      "394721069",
                      "394725318",
                      "394726623",
                      "394727322",
                      "394728970",
                      "397260671",
                      "394729503",
                      "394730203",
                      "394733745",
                      "394738543",
                      "394741829",
                      "394742857",
                      "394744075",
                      "394746727"]
    
    static let advancedVideoTitles = ["Position Sizing",
                       "Position Size Calculator",
                       "What Really Moves the Market?",
                       "Special Structures",
                       "Market Structures",
                       "Liquidity",
                       "Understanding the 5 Trading Sessions",
                       "Indicators VS Price Action",
                       "ATR Indicator",
                       "Using Indicators as Confluence with Price Action",
                       "Imbalances",
                       "Exits in the Markets",
                       "NFP",
                       "What Pairs I Should Trade?",
                       "Best Times of the Day to Trade",
                       "How to Set Profit Levels Effectively",
                       "Practical Steps to Maximise Your Trading",
                       "Traders Timeline",
                       "Equity threshold",
                       "Building your Trading Plan",
                       "How to Deal with Losing Days",
                       "Habits of a Profitable Trader",
                       "Finding Your Trading Style",
                       "Lower Time Frame Analysis",
                       "Advanced Fibs",
                       "Transition Protocol",
                       "Maximising your Risk-Reward using lower time frames",
                       "Liquidity",
                       "Inter-Session Liquidity and Exploiting Liquidity Across Sessions",
                       "Inter-Session Liquidity Part 2",
                       "Difference between Order Flow and Market Structure",
                       "Order Flow vs Market Structure Part 2",
                       "Different Types of Mitigation",
                       "Advanced market structure and time",
                       "Wyckoff",
                       "Wyckoff Part 2"]
    
    static let advancedVideoIds = ["541116492",
                      "541119772",
                      "531404307",
                      "531424836",
                      "531450263",
                      "531472194",
                      "531500855",
                      "531572204",
                      "531581142",
                      "531589565",
                      "531592426",
                      "531597186",
                      "531602911",
                      "532084359",
                      "532080358",
                      "532081081",
                      "532078119",
                      "532082589",
                      "532083711",
                      "532079435",
                      "532085409",
                      "532087499",
                      "532076966",
                      "532698232",
                      "532722285",
                      "532726852",
                      "532728920",
                      "532731476",
                      "532733704",
                      "532737007",
                      "532739029",
                      "532739969",
                      "532741542",
                      "532742869",
                      "541141896",
                      "541145017"]
    
    static let videoLinks = ["https://vimeo.com/394771909/04b6071c16",
                      "https://vimeo.com/394712319/9a2697ab2f",
                      "https://vimeo.com/394712633/12a736b36c",
                      "https://vimeo.com/394721069/ca0e54ceab",
                      "https://vimeo.com/394725318/b83162b29a",
                      "https://vimeo.com/394726623/927ce7f7f4",
                      "https://vimeo.com/394727322/ac0d9b7178",
                      "https://vimeo.com/394728970/bcbaf6f29a",
                      "https://vimeo.com/397260671/3d67c257ca",
                      "https://vimeo.com/394729503/c2acccc673",
                      "https://vimeo.com/394730203/f6edaf51bc",
                      "https://vimeo.com/394733745/f24d3ee35e",
                      "https://vimeo.com/394738543/e747564494",
                      "https://vimeo.com/394741829/0baa5d5c11",
                      "https://vimeo.com/394742857/3b168c732b",
                      "https://vimeo.com/394744075/3dcba4a8d4",
                      "https://vimeo.com/394746727/9f6fc4d0e9"]
    static let helpVideoIds = ["594899742",//"594816154",
                               "593397459"]
    
    static let states = ["Alabama",
                         "Alaska",
                         //"American Samoa",
                         "Arizona",
                         "Arkansas",
                         "California",
                         "Colorado",
                         "Connecticut",
                         "Delaware",
                         "District Of Columbia",
                         //"Federated States Of Micronesia",
                         "Florida",
                         "Georgia",
                         //"Guam",
                         "Hawaii",
                         "Idaho",
                         "Illinois",
                         "Indiana",
                         "Iowa",
                         "Kansas",
                         "Kentucky",
                         "Louisiana",
                         "Maine",
                         //"Marshall Islands",
                         "Maryland",
                         "Massachusetts",
                         "Michigan",
                         "Minnesota",
                         "Mississippi",
                         "Missouri",
                         "Montana",
                         "Nebraska",
                         "Nevada",
                         "New Hampshire",
                         "New Jersey",
                         "New Mexico",
                         "New York",
                         "North Carolina",
                         "North Dakota",
                         //"Northern Mariana Islands",
                         "Ohio",
                         "Oklahoma",
                         "Oregon",
                         //"Palau",
                         "Pennsylvania",
                         //"Puerto Rico",
                         "Rhode Island",
                         "South Carolina",
                         "South Dakota",
                         "Tennessee",
                         "Texas",
                         "Utah",
                         "Vermont",
                         //"Virgin Islands",
                         "Virginia",
                         "Washington",
                         "West Virginia",
                         "Wisconsin",
                         "Wyoming"]
    
    static let statesDict = ["Alabama": "AL",
        "Alaska": "AK",
        //"American Samoa": "AS",
        "Arizona": "AZ",
        "Arkansas": "AR",
        "California": "CA",
        "Colorado": "CO",
        "Connecticut": "CT",
        "Delaware": "DE",
        "District Of Columbia": "DC",
        //"Federated States Of Micronesia": "FM",
        "Florida": "FL",
        "Georgia": "GA",
        //"Guam": "GU",
        "Hawaii": "HI",
        "Idaho": "ID",
        "Illinois": "IL",
        "Indiana": "IN",
        "Iowa": "IA",
        "Kansas": "KS",
        "Kentucky": "KY",
        "Louisiana": "LA",
        "Maine": "ME",
        //"Marshall Islands": "MH",
        "Maryland": "MD",
        "Massachusetts": "MA",
        "Michigan": "MI",
        "Minnesota": "MN",
        "Mississippi": "MS",
        "Missouri": "MO",
        "Montana": "MT",
        "Nebraska": "NE",
        "Nevada": "NV",
        "New Hampshire": "NH",
        "New Jersey": "NJ",
        "New Mexico": "NM",
        "New York": "NY",
        "North Carolina": "NC",
        "North Dakota": "ND",
        //"Northern Mariana Islands": "MP",
        "Ohio": "OH",
        "Oklahoma": "OK",
        "Oregon": "OR",
        //"Palau": "PW",
        "Pennsylvania": "PA",
        //"Puerto Rico": "PR",
        "Rhode Island": "RI",
        "South Carolina": "SC",
        "South Dakota": "SD",
        "Tennessee": "TN",
        "Texas": "TX",
        "Utah": "UT",
        "Vermont": "VT",
        //"Virgin Islands": "VI",
        "Virginia": "VA",
        "Washington": "WA",
        "West Virginia": "WV",
        "Wisconsin": "WI",
        "Wyoming": "WY"]
}

class Config: NSObject {
    static var AUTH_HEADER: HTTPHeaders {
        return ["Authorization" : "Bearer \(Config.retrieveString(Constants.USER_TOKEN))"]
    }
    
    static var isUserLoggedIn: Bool {
        return self.retrieveString(Constants.USER_TOKEN).count > 0
    }
    
    class func logout() {
        Config.removeObject(Constants.USER_TOKEN)
        Config.removeObject(Constants.NOTIFICATION_ON)
        Config.removeObject(Constants.USER_EMAIL)
        Config.removeObject(Constants.USER_PASS)
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func saveObject(_ object: Any, key: String) {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func retrieveObject(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func retrieveString(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    class func removeObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func showMessage(_ viewController: UIViewController, _ message: String, _ handler: ((_ action:UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true)
    }
    
    class func showExpiredMessage(_ viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: "Your session has expired. Please login again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.openLoginVC()
        }))
        viewController.present(alert, animated: true)
    }
    
    class func openLoginVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        //controller.modalTransitionStyle = .flipHorizontal
        //self.present(controller, animated: true, completion: nil)
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDel.window else {
            return
        }
        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
    
    class func callCheckDeviceMethod(_ viewController: UIViewController) {
        APICall.checkDevice() { result in
            APICall.hideHUD()
            if result {
                Config.logout()
                Config.showExpiredMessage(viewController)
            }
        }
    }
}

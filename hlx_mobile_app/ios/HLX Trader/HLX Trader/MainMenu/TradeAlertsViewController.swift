//
//  TradeAlertsViewController.swift
//  HLX Trader
//

import UIKit
import UserNotifications
import RLBAlertsPickers
import Starscream
import SwiftyJSON

class TradeAlertsViewController: UIViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var loginAlertView: UIView!
    @IBOutlet weak var tradeSettingView: UIView!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var tradeDataView: UIView!
    @IBOutlet weak var tradeDataTextView: UITextView!
    
    @IBOutlet weak var tradeDataTableView: UITableView!
    var tradeData = [JSON]()
    
    let tradeLevels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var socket: WebSocket!
    var isReceivedData = false
    var isConnected = false
    
    lazy var helpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.contentHorizontalAlignment = .right
        //btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -5)
        //btn.tintColor = UIColor.white
        btn.setTitle("Help", for: .normal)
        btn.addTarget(self, action: #selector(rightMenuButtonClicked), for: .touchUpInside)
        
        //btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        //btn.backgroundColor = .white
        //btn.cornerRadius = 5
        //btn.borderColor = UIColor.init(hex: 0xFDB913)
        //btn.borderWidth = 2
        
        return btn
    }()
    
    @objc func rightMenuButtonClicked() {
        if let notificationsVC = storyboard?.instantiateViewController(withIdentifier: "HelpTradeViewController") {
            self.navigationController?.pushViewController(notificationsVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        //self.initTradeView()
        
        //if Config.isUserLoggedIn {
        //    self.getNotificationMethod()
        //}
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if Config.isUserLoggedIn {
//            self.callCheckDeviceMethod()
//        } else {
            self.initTradeView()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.disconnectSocket()
        APICall.hideHUD()
    }
    
    @objc func willEnterForeground() {
//        if Config.isUserLoggedIn {
//            self.callCheckDeviceMethod()
//        } else {
            self.initTradeView()
//        }
    }
    
    @objc func didEnterBackground() {
        self.disconnectSocket()
    }
    
    /*@objc func willResignActive() {
        self.disconnectSocket()
    }*/
    
    func initTradeView() {
//        if Config.isUserLoggedIn {
            //self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.helpButton)
            //self.checkNotificationStaus()
            self.loginAlertView.isHidden = true
            self.tradeSettingView.isHidden = false
            self.tradeDataView.isHidden = false
            
            self.getNotificationMethod()
            self.reloadTradeData()
            self.initWebSocket()
//        }
        /* else {
            self.tabBarController?.navigationItem.rightBarButtonItem = nil
            self.disconnectSocket()
            self.loginAlertView.isHidden = false
            self.tradeSettingView.isHidden = true
            self.tradeDataView.isHidden = true
        }*/
    }
    
    func checkSocketStatus() {
        //if !Config.isUserLoggedIn && self.isConnected {
        //    self.disconnectSocket()
        //}
        
//        if Config.isUserLoggedIn != self.isConnected {
//            self.initTradeView()
//        }
    }
    
    func disconnectSocket() {
        self.isConnected = false
        self.isReceivedData = false
        if self.socket != nil {
            self.socket.disconnect()
        }
        APICall.hideHUD()
    }
    
    @IBAction func changedNotificationSwitch(_ sender: UISwitch) {
        if sender.isOn {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    DispatchQueue.main.async {
                        self.setNotificationSwitch(true)
                        self.postNotificationMethod()
                    }
                } else {
                    self.setNotificationSwitch(false)
                    self.promptUserForAllow()
                }
            }
        } else {
            self.deleteNotificationMethod()
        }
    }
    
    func checkNotificationStaus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                self.setNotificationSwitch(Config.retrieveObject(Constants.NOTIFICATION_ON) as? Bool ?? false)
            } else {
                self.setNotificationSwitch(false)
            }
        }
    }
    
    func setNotificationSwitch(_ isOn: Bool) {
        DispatchQueue.main.async {
            Config.saveObject(isOn, key: Constants.NOTIFICATION_ON)
            self.notificationSwitch.isOn = isOn
        }
    }
    
    func promptUserForAllow() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Allow Notification", message: "This app requires allow notification!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (UIAlertAction) in
                UIApplication.shared.open(NSURL.init(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
            }
            alert.addAction(settingsAction)
            self.present(alert, animated: true)
        }
    }
    
    func showTradePickerView() {
        let alert = UIAlertController(style: .actionSheet, title: "Select a trade idea", message: "")
        
        let pickerViewValues: [[String]] = [self.tradeLevels.map { $0 }]
        let currentIndex = self.tradeLevels.firstIndex(of: self.levelTextField.text!) ?? 0
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: currentIndex)
        alert.addPickerView(values: pickerViewValues, initialSelection: [pickerViewSelectedValue]) { vc, picker, index, values in
            self.levelTextField.text = self.tradeLevels[index.row]
        }
        
        alert.addAction(title: "Done", style: .cancel, handler: { _ in
            if self.levelTextField.text?.count == 0 {
                self.levelTextField.text = self.tradeLevels[currentIndex]
            }
            
            if self.notificationSwitch.isOn {
                self.postNotificationMethod()
            }
        })
        alert.show(vibrate: true)
    }
    
    func initWebSocket() {
//        let token = Config.retrieveString(Constants.USER_TOKEN)
//        if token.count == 0 {
//            self.showMessage("Your session has expired. Please login to access premium content!")
//            return
//        }
        guard let socketUrl = URL(string: URLs.TRADE_WEBSOCKET_URL) else {
//            self.showMessage("Your session has expired. Please login to access premium content!")
            self.showMessage("Your session has expired. Please try again later!")
            return
        }
        
        //APICall.showHUD(status: "Connecting to servers, Please wait...")
        self.isConnected = true
        var request = URLRequest(url: socketUrl)
        request.timeoutInterval = 5
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
        self.socket.connect()
        
        /*APICall.afterDelay(30, {
            if !self.isConnected {
                self.disconnectSocket()
            }
        })*/
    }
    
    func getNotificationMethod() {
        APICall.getNotification() { (result, response) in
            if result {
                if let levelJson = response {
                    let json = JSON(parseJSON: levelJson)
                    self.levelTextField.text = json["level"].stringValue
                    self.setNotificationSwitch(true)
                }
            } else {
                guard let reason = response else {
                    return
                }
                   
//                if reason == "invalid_token" {
//                    self.invalidToken()
//                    print(reason)
//                } else
                if reason == "invalid_level" {
                    self.levelTextField.text = ""
                    self.setNotificationSwitch(false)
                } else {
                    print(reason)
                }
            }
        }
    }
    
    func postNotificationMethod() {
        let level = self.levelTextField.text!
        if level.count == 0 {
            self.setNotificationSwitch(false)
            self.showMessage("Please select a trade idea!")
            return
        }
        
        APICall.postNotification(level, completion: { result in
            APICall.hideHUD()
//            if result {
//                self.invalidToken()
//            }
        })
    }
    
    func deleteNotificationMethod() {
        self.levelTextField.text = ""
        self.setNotificationSwitch(false)
        
        APICall.deleteNotification() { result in
            APICall.hideHUD()
//            if result {
//                self.invalidToken()
//            }
        }
    }
    
//    func callCheckDeviceMethod() {
//        if !self.isConnected {
//            APICall.showHUD(status: "Connecting to servers, Please wait...")
//        }
//        APICall.checkDevice() { result in
//            if result {
//                APICall.hideHUD()
//                self.invalidToken()
//            } else {
//                self.checkSocketStatus()
//            }
//        }
//    }
    
//    func invalidToken() {
//        Config.logout()
//        //self.initTradeView()
//        //self.showMessage("Your session has expired. Please login to access premium content!")
//        Config.showExpiredMessage(self)
//    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func showWebSocketError() {
        let alert = UIAlertController(title: nil, message: "Failed getting trade data from server. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Reconnect", style: .default) { (UIAlertAction) in
            self.initWebSocket()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension TradeAlertsViewController: UITextFieldDelegate, WebSocketDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.levelTextField {
            self.showTradePickerView()
            return false
        } else {
            return true
        }
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
            //self.isConnected = true
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
            APICall.hideHUD()
            self.isConnected = false
            self.isReceivedData = false
            
            //self.initTradeView()
        case .text(let string):
//            print("Received text: \(string)")
            if !self.isReceivedData {
                APICall.hideHUD(true, 0.5)
                self.isReceivedData = true
            }
            self.updateTradeData(string)
        case .cancelled:
            APICall.hideHUD()
            self.isConnected = false
            self.isReceivedData = false
        case .error(let error):
            //self.tradeDataTextView.text = ""
            self.disconnectSocket()
            self.reloadTradeData()
            self.handleError(error)
        default:
            break
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? HTTPUpgradeError  {
            switch e {
            case .notAnUpgrade(403):
//                self.invalidToken()
                self.showMessage("Failed to fetch data. Please try again later!")
                return
            case .notAnUpgrade(409):
//                self.showMessage("It seems like you're logged in on another device, in order to login please logout from the other device and try again.")
                self.showMessage("Your session has expired. Please try again later!")
                return
            case .notAnUpgrade(423):
                self.showMessage("No data on weekend!")
                return
            default:
                break
            }
        }
        self.showWebSocketError()
    }
    
    func updateTradeData(_ data: String) {
        if data.count == 0 {
            return
        }
        
        let jsonData = JSON(parseJSON: data)
        self.reloadTradeData(jsonData.arrayValue)
        
        /*var tradeData = ""
        for item in jsonData.arrayValue {
            let pair = item["pair"].stringValue
            let drawdown = item["drawdown"].stringValue
            let level = item["level"].stringValue
            tradeData += pair + " - " + drawdown + "% - " + level + "\n"
        }
        
        self.tradeDataTextView.text = tradeData*/
    }
    
    func reloadTradeData(_ tradeData:[JSON] = []) {
        self.tradeData = tradeData
        self.tradeDataTableView.reloadData()
    }
}

extension TradeAlertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tradeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TradeDataCell") as! TradeDataCell
        cell.tradeData = self.tradeData[indexPath.row]
        return cell
    }
}

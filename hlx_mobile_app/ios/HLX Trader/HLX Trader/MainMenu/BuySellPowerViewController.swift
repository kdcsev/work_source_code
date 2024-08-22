//
//  BuySellPowerViewController.swift
//  HLX Trader
//

import UIKit
import WebKit
import RLBAlertsPickers

class BuySellPowerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var currencyWebView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var currentCurrecy = ""
    
    let currencies = ["AUDCAD", "AUDJPY","AUDNZD","AUDUSD","CADJPY", "USDCHF", "USDJPY", "USDCAD", "NZDUSD", "NZDJPY", "NZDCAD", "EURUSD", "EURJPY", "EURGBP", "EURAUD", "EURCAD", "GBPUSD", "GBPCAD", "GBPJPY"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currencyWebView.navigationDelegate = self
        self.currencyWebView.scrollView.isScrollEnabled = false
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //currencyTextField.inputView = pickerView
        //currencyTextField.textAlignment = .center
        //currencyTextField.placeholder = "Select Currency Pair"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func powerButton(_ sender: UIButton) {
        
        switch currencyTextField.text {
        
        case currencies[0]:
            performSegue(withIdentifier: "SliderUSDCAD", sender: self)
            errorText.text = ""
            
        case currencies[2]:
            performSegue(withIdentifier: "SliderGBPCAD", sender: self)
            errorText.text = ""
        default:
            errorText.text = "Please Select a Currency Pair First!"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyTextField.text = currencies[row]
        currencyTextField.resignFirstResponder()
    }
    
    func showCurrencyPickerView() {
        let alert = UIAlertController(style: .actionSheet, title: "Please select a currency", message: "")
        
        let pickerViewValues: [[String]] = [self.currencies.map { $0 }]
        let currentIndex = self.currencies.firstIndex(of: self.currencyTextField.text!) ?? 0
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: currentIndex)
        alert.addPickerView(values: pickerViewValues, initialSelection: [pickerViewSelectedValue]) { vc, picker, index, values in
            self.currencyTextField.text = self.currencies[index.row]
        }
        
        alert.addAction(title: "Done", style: .cancel, handler: { _ in
            if self.currencyTextField.text?.count == 0 {
                self.currencyTextField.text = self.currencies[currentIndex]
            }
            
            self.loadCurrencyView()
        })
        alert.show(vibrate: true)
    }
    
    func loadCurrencyView() {
        if self.currentCurrecy == self.currencyTextField.text {
            return
        } else {
            self.currentCurrecy = self.currencyTextField.text!
            
            let currentIndex = self.currencies.firstIndex(of: self.currentCurrecy) ?? -1
            self.loadCurrencyContent(currentIndex)
            /*switch currentIndex {
            case 0, 2:
                self.loadCurrencyContent(currentIndex)
                break
            default:
                self.currencyWebView.isHidden = true
                self.showMessage("Please Select a Currency Pair First!")
                break
            }*/
        }
    }
    
    func loadCurrencyContent(_ index: Int) {
        if let htmlPath = Bundle.main.path(forResource: "currency", ofType: "html") {
            //let url = URL(fileURLWithPath: htmlPath)
            //let request = URLRequest(url:url)
            //self.currencyWebView.load(request)
            if var htmlString = try? String(contentsOfFile: htmlPath) {
                self.currencyWebView.isHidden = false
                htmlString = htmlString.replacingOccurrences(of: "{currency}", with: self.currencies[index])
                self.currencyWebView.loadHTMLString(htmlString, baseURL: nil)
                
                return
            }
        }
        
        self.currencyWebView.isHidden = true
        self.showMessage("Please Select a Currency Pair First!")
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension BuySellPowerViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.currencyTextField {
            self.showCurrencyPickerView()
            return false
        } else {
            return true
        }
    }
}

extension BuySellPowerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loadingView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.stopAnimating()
        //self.currencyWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingView.stopAnimating()
    }
}


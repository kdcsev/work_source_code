//
//  SplashViewController.swift
//

import UIKit
import AVFoundation
import M13Checkbox

class SplashViewController: UIViewController {
    var player: AVPlayer?
    
    
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var pleaseAccept: UILabel!
    @IBOutlet weak var riskReader: UIButton!
    @IBOutlet weak var hlxDelayLogo: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var agreeCheckbox: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            UIView.animate(withDuration: 1) {
                self.containerView.alpha = 1
            }
        }
        
        playBackgroundVideo()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapDisclaimerLabel(gesture:)))
        disclaimerLabel.addGestureRecognizer(gesture)
        
        let agreed = UserDefaults.standard.string(forKey: "hlx_agreed") ?? ""
        if agreed == "1" {
            agreeCheckbox.checkState = .checked
            pleaseAccept.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func playBackgroundVideo() {
        
        let path = Bundle.main.path(forResource: "back_video", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at:0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        return
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        if self.agreeCheckbox.checkState == .checked {
//            if Config.isUserLoggedIn {
//                self.callCheckTokenMethod()
//            } else {
//                Config.openLoginVC()
//            }
            self.openMainVC()
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.pleaseAccept.center.x - 10, y: self.pleaseAccept.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.pleaseAccept.center.x + 10, y: self.pleaseAccept.center.y))

            pleaseAccept.layer.add(animation, forKey: "position")
        }
    }
    
    @IBAction func checkboxValueChanged(_ sender: M13Checkbox) {
        if sender.checkState == .checked {
            self.pleaseAccept.isHidden = true
            UserDefaults.standard.set("1", forKey: "hlx_agreed")
        } else {
            self.pleaseAccept.isHidden = false
            UserDefaults.standard.set("", forKey: "hlx_agreed")
        }
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
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
    
    @objc func tapDisclaimerLabel(gesture: UITapGestureRecognizer) {
        let disclaimerText = (self.disclaimerLabel.text)!
        let checkRange = (disclaimerText as NSString).range(of: "I Read and Accept")
        let disclaimerRange = (disclaimerText as NSString).range(of: "HLX Disclaimer")
        if gesture.didTapAttributedTextInLabel(label: self.disclaimerLabel, inRange: checkRange) {
            if self.agreeCheckbox.checkState == .checked {
                self.agreeCheckbox.setCheckState(.unchecked, animated: true)
            } else {
                self.agreeCheckbox.setCheckState(.checked, animated: true)
            }
            self.checkboxValueChanged(self.agreeCheckbox)
        } else if gesture.didTapAttributedTextInLabel(label: self.disclaimerLabel, inRange: disclaimerRange) {
            self.performSegue(withIdentifier: "showDisclaimerVC", sender: nil)
        }
    }
    
//    func callCheckTokenMethod() {
//        APICall.checkToken() { result in
//            APICall.hideHUD()
//            if result {
//                Config.logout()
//            }
//            self.openMainVC()
//        }
//    }
}

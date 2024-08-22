//
//  MainTabBarController.swift
//

import UIKit
import AudioToolbox

class MainTabBarController: UITabBarController {
    
    var selectedTabIndex: Int = 0
    var titleView: UIView!
    
    lazy var helpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn.contentHorizontalAlignment = .right
        btn.setTitle("Help", for: .normal)
        btn.addTarget(self, action: #selector(rightMenuButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        //let marginX = ((self.navigationController?.navigationBar.frame.size.width)! - 140) / 2
        //imageView.frame = CGRect(x: marginX, y: 0, width: 140, height: 36);
        //self.navigationController?.navigationBar.addSubview(imageView)
        self.delegate = self
        self.addNavigationBarImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "ic_logo_black"), for: .default)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let index = tabBar.items?.firstIndex(of: item)
        if index == 0 {
            self.addNavigationBarImage()
        } else {
            self.navigationItem.titleView = self.titleView
            self.navigationItem.title = item.title
        }
        
        
        if index == 1 && Config.isUserLoggedIn {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.helpButton)
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        //self.transparentNavigationBar(index)
        
        if index != self.selectedTabIndex {
            self.selectedTabIndex = index!
            self.animationIndex(index: index!)
        }
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if let selectedViewController = selectedViewController {
            return selectedViewController.supportedInterfaceOrientations
        }
        return .allButUpsideDown
    }
    
    func animationIndex(index: NSInteger) {
        var tabbarBtnArray:[Any] = [Any]()
        
        for tabbarBtn in self.tabBar.subviews {
            if tabbarBtn .isKind(of: NSClassFromString("UITabBarButton")!)  {
                tabbarBtnArray.append(tabbarBtn)
            }
        }
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.0, 1.3, 0.9, 1.15, 0.95, 1.02, 1.0]
        animation.duration = 1
        animation.calculationMode = CAAnimationCalculationMode.cubic
        
        let tabBarLayer = (tabbarBtnArray[index] as AnyObject).layer
        tabBarLayer?.add(animation, forKey: nil)
    }
    
    @objc func rightMenuButtonClicked() {
        if let notificationsVC = storyboard?.instantiateViewController(withIdentifier: "HelpTradeViewController") {
            self.navigationController?.pushViewController(notificationsVC, animated: true)
        }
    }
    
    func addNavigationBarImage() {
        self.titleView = self.navigationItem.titleView
        let imageView = UIImageView(image:#imageLiteral(resourceName: "ic_logo_nav"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func transparentNavigationBar(_ index : Int? = 0) {
        if index == 0 {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    /*func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let fromView: UIView = tabBarController.selectedViewController!.view
         let toView  : UIView = viewController.view
         if fromView == toView {
         return false
         }
         
         UIView.transition(from: fromView, to: toView, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve) { (finished:Bool) in
         }*/
        
        
        /*guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        
        self.animateToTab(toIndex: toIndex)
        return true
    }*/
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        AudioServicesPlaySystemSound(1104)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return MyTransition(viewControllers: tabBarController.viewControllers)
        }
    
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
              let selectedVC = selectedViewController else { return }
        
        guard let fromView = selectedVC.view,
              let toView = tabViewControllers[toIndex].view,
              let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
              fromIndex != toIndex else { return }
        
        
        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        //let fadeView = fromView.viewWithTag(1000)
        //fadeView?.alpha = 0.8
        
        view.isUserInteractionEnabled = false
        
        AudioServicesPlaySystemSound(1104)//1103, 1104, 1105, 1111
        
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .transitionCrossDissolve,
                       animations: {
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
                        
                       }, completion: { finished in
                        
                        fromView.removeFromSuperview()
                        self.selectedIndex = toIndex
                        self.view.isUserInteractionEnabled = true
                       })
    }
}

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.2

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        let quarterFrame = frame.width * 0.25
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - quarterFrame : frame.origin.x + quarterFrame
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + quarterFrame : frame.origin.x - quarterFrame
        toView.frame = toFrameStart

        let toCoverView = fromView.snapshotView(afterScreenUpdates: false)
        if let toCoverView = toCoverView {
            toView.addSubview(toCoverView)
        }
        
        let fromCoverView = toView.snapshotView(afterScreenUpdates: false)
        if let fromCoverView = fromCoverView {
            fromView.addSubview(fromCoverView)
        }

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [.curveEaseOut], animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
                toCoverView?.alpha = 0
                fromCoverView?.alpha = 1
            }) { (success) in
                fromCoverView?.removeFromSuperview()
                toCoverView?.removeFromSuperview()
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            }
        }
    }

    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}

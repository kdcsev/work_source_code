//
//  MainTabBarController.swift
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var selectedTabIndex: Int = 0
    
    override func viewDidLoad() {
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item)
        
        if index != self.selectedTabIndex {
            self.selectedTabIndex = index!
            self.animationIndex(index: index!)
        }
    }
    
    override var shouldAutorotate: Bool {
        //if let selectedViewController = selectedViewController {
        //    return selectedViewController.shouldAutorotate
        //}
        
        return true
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
}

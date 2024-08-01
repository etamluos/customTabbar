//
//  TTViewController.swift
//  MyTabbar
//
//  Created by Tungpv on 30/7/24.
//

import UIKit

import Lottie

class Custom2TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var lottieAnimationViews: [LottieAnimationView] = {

        let animationView0 = LottieAnimationView(name: "0") // replace with your animation file name
        animationView0.contentMode = .scaleAspectFit
        animationView0.loopMode = .playOnce
        
        let animationView1 = LottieAnimationView(name: "1") // replace with your animation file name
        animationView1.contentMode = .scaleAspectFit
        animationView1.loopMode = .playOnce
        
        let animationView2 = LottieAnimationView(name: "2") // replace with your animation file name
        animationView2.contentMode = .scaleAspectFit
        animationView2.loopMode = .playOnce
        
        let animationView3 = LottieAnimationView(name: "3") // replace with your animation file name
        animationView3.contentMode = .scaleAspectFit
        animationView3.loopMode = .playOnce
        
        let animationView4 = LottieAnimationView(name: "4") // replace with your animation file name
        animationView4.contentMode = .scaleAspectFit
        animationView4.loopMode = .playOnce
        
        return [animationView0, animationView1, animationView2, animationView3, animationView4]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Initialize your view controllers
        let firstViewController = FirstViewController()
        let firstTabBarItem = UITabBarItem(title: "", 
                                           image: UIImage(named: "0"),
                                           selectedImage: UIImage(named: ""))
        let animationView = LottieAnimationView(name: "footer-ic-study-txt-on") // replace with your animation file name
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.isHidden = true
        firstViewController.tabBarItem = firstTabBarItem
        
        let secondViewController = SecondViewController()
        let secondTabBarItem = UITabBarItem(title: "", 
                                            image: UIImage(named: "1"),
                                            selectedImage: UIImage(named: ""))
        secondViewController.tabBarItem = secondTabBarItem

        viewControllers = [firstViewController, secondViewController]
        let ani = lottieAnimationViews.first!
        ani.frame = tabBar.subviews.first!.bounds
        tabBar.subviews.first?.addSubview(ani)
        
        // Add Lottie animations to tab bar items
//        setupLottieAnimations()
    }

    private func setupLottieAnimations() {
        guard let tabBarItems = tabBar.items else { return }
        
        for (index, item) in tabBarItems.enumerated() {
            let animationView = LottieAnimationView(name: "footer-ic-study-txt-on") // replace with your animation file name
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.isHidden = true
            
            // Add the Lottie animation view to the tab bar item
            tabBar.addSubview(animationView)
            lottieAnimationViews.append(animationView)
            
            // Set up constraints for the Lottie animation view
            animationView.translatesAutoresizingMaskIntoConstraints = false
            let tabBarItemFrame = tabBar.subviews[index + 1].frame
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: tabBar.subviews[index + 1].centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: tabBar.subviews[index + 1].centerYAnchor),
                animationView.widthAnchor.constraint(equalToConstant: tabBarItemFrame.width),
                animationView.heightAnchor.constraint(equalToConstant: tabBarItemFrame.height)
            ])
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = viewControllers?.firstIndex(of: viewController) else { return }
        
        for (i, animationView) in lottieAnimationViews.enumerated() {
            if i == index {
                animationView.isHidden = false
                animationView.play { (finished) in
                    animationView.isHidden = true
                }
            } else {
                animationView.isHidden = true
            }
        }
    }
}




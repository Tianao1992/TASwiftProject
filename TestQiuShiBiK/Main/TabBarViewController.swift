//
//  TabBarViewController.swift
//  testQiushi
//
//  Created by tianao on 2021/1/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置tabbar
        setValue(TabBar(), forKeyPath: "tabBar")
        tabBar.barTintColor = UIColor.white
        addChild("糗事", "icon_main", "icon_main_active", HomeViewController.self)
        addChild("动态", "main_tab_live", "main_tab_live_active", TrendViewController.self)
        addChild("直播", "main_tab_live", "main_tab_live_active", LiveViewController.self)
        
    }
    
    func addChild(_ title: String,
                  _ image: String,
                  _ selectedImage: String,
                  _ type: UIViewController.Type) {
        let child = UINavigationController(rootViewController: type.init())
        child.title = title
        child.tabBarItem.image = UIImage(named: image)
        child.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        
        child.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
        addChild(child)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

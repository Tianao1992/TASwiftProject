//
//  TabBar.swift
//  testQiushi
//
//  Created by tianao on 2021/1/25.
//

import UIKit

class TabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        for button in subviews where button is UIControl {
            var frame = button.frame
            frame.origin.y = -2
            button.frame = frame
        }
    }

}

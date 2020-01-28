//
//  TabBarController.swift
//  sns-api
//
//  Created by saya on 2020/01/22.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // カスタマイズ

        // アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 235/255, green: 105/255, blue: 122/255, alpha: 1.0)
        // 背景色
//        UITabBar.appearance().barTintColor = UIColor(red: 66/255, green: 74/255, blue: 93/255, alpha: 1.0) // grey black

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

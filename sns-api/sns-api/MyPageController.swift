//
//  MyPageController.swift
//  sns-api
//
//  Created by saya on 2020/01/17.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class MyPageController: UIViewController {
    
    @IBAction func gotoUserEditViewController(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let UserEditViewController = storyboard.instantiateViewController(withIdentifier: "UserEditViewController")
            self.present(UserEditViewController, animated: true, completion: nil)
            print("画面遷移成功してるよ")
        }
    }
    //    @IBAction func userEditButton(_ sender: Any) {
//                    DispatchQueue.main.async {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let UserEditViewController = storyboard.instantiateViewController(withIdentifier: "UserEditViewController")
//            //                                    self.navigationController?.pushViewController(MyPageController, animated: true)
//                self.present(UserEditViewController, animated: true, completion: nil)
    //
//                 DispatchQueue.main.async {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let UserEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserEditViewController") as! UserEditViewController
//                    self.present(UserEditViewController, animated: true, completion: nil)
////                                     }
        
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserEditViewController")
//        present(nextVC!, animated: true, completion: nil)
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let UserEditViewController = storyboard.instantiateViewController(withIdentifier: "UserEditViewController")
//        self.navigationController?.pushViewController(UserEditViewController, animated: true)
//    }
    
    @IBAction func testPage(_ sender: Any) {
        DispatchQueue.main.async {

           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let testController = storyboard.instantiateViewController(withIdentifier: "testController")
//           self.navigationController?.pushViewController(loginViewController, animated: true)
           self.present(testController, animated: true, completion: nil)
            print("画面遷移成功してるよ")
        }
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UserEditViewController")
//        present(nextVC!, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


        
 
}

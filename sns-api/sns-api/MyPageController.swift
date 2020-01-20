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
    @IBAction func gotoPostController(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let postController = storyboard.instantiateViewController(withIdentifier: "postController")
            self.present(postController, animated: true, completion: nil)
            print("ツイート作成画面に遷移成功してるよ")
        }
    }
    
    @IBAction func SearchPage(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let SearchController = storyboard.instantiateViewController(withIdentifier: "SearchController")
            self.present(SearchController, animated: true, completion: nil)
            print("ユーザー検索ページに遷移成功してるよ")
        }
        
    }
    
    @IBAction func gotoTimeline(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let AllTimelineController = storyboard.instantiateViewController(withIdentifier: "AllTimelineController")
            self.navigationController?.pushViewController(AllTimelineController, animated: true)
//            self.present(AllTimelineController, animated: true, completion: nil)
            print("タイムラインに遷移成功してるよ")
        }
    }
    @IBOutlet weak var myName: UITextView!
//    let defaults = UserDefaults.standard
//    myName.text = defaults.string(forKey: "responseName")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 
}

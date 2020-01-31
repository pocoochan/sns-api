//
//  ContainerViewController.swift
//  sns-api
//
//  Created by saya on 2020/01/31.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBAction func newPostButton(_ sender: Any) {
        DispatchQueue.main.async {
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let postController = storyboard.instantiateViewController(withIdentifier: "postController")
                   self.present(postController, animated: true, completion: nil)
                   print("ツイート作成画面に遷移成功してるよ")
               }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

//
//  postController.swift
//  sns-api
//
//  Created by saya on 2020/01/20.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class postController: UIViewController {

    @IBOutlet weak var postWrite: UITextField!
    @IBAction func tweetButton(_ sender: Any) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let text = postWrite.text
        
    //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let newPostParams = [
            "text": text,
        ]
        
        //URLオブジェクトの生成
        let url = URL(string: "https://teachapi.herokuapp.com/posts")!
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //ボディーを付与（2つめの辞書）
        let parameter = ["post_params": newPostParams]
        
        req.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        
        print(String(data: req.httpBody!, encoding: .utf8))
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            print(data)
            print(error)
            
            let responseString: String =  String(data: data!, encoding: .utf8)!
            print(responseString)
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print(response)
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
//                DispatchQueue.main.async {
//
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let MyPageController = storyboard.instantiateViewController(withIdentifier: "MyPageController")
//                    self.navigationController?.pushViewController(MyPageController, animated: true)
//                    //                            self.present(MyPageController, animated: true, completion: nil)
                
//                    print("マイページへの画面遷移成功だよ")
//                }
                
            } catch{
                
            }
            
        }
        task.resume()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 
}

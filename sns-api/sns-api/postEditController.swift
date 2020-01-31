//
//  postEditController.swift
//  sns-api
//
//  Created by saya on 2020/01/30.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class postEditController: UIViewController {
    //受け取る値を格納するもの
    
    var indexRowDictionaryId: Any!
    
    @IBOutlet weak var postEditText: UITextField!
    @IBAction func postEditButton(_ sender: Any) {
         print(indexRowDictionaryId!)
        
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let text = postEditText.text
        
        //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let editPostParams = [
            "text": text,
        ]
        
        //URLオブジェクトの生成
        let number = indexRowDictionaryId!
        print(number)
        let url = URL(string: "https://teachapi.herokuapp.com/posts/\(number)")!
        
        print(url)
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "PUT"
        
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //ボディーを付与（2つめの辞書）
        let parameter = ["post_params": editPostParams]
        
        req.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        
        print(String(data: req.httpBody!, encoding: .utf8))
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print(response)
                
                print("投稿が編集されたよ")
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
//                    self.myTV.reloadData()
                }
                
            } catch{
                
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(indexRowDictionaryId!)
    }
}

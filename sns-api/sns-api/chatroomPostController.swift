
//
//  chatroomPostController.swift
//  sns-api
//
//  Created by saya on 2020/01/31.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit
class chatroomPostController: UIViewController {
    
    //受け取る値を格納するもの
    var indexRowDictionaryId: Any!
    
    @IBOutlet weak var chatNewPost: UITextField!
   
    @IBAction func messageSent(_ sender: Any) {
    }
    
    @IBAction func chatMessageSent(_ sender: Any) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let text = chatNewPost.text
        
        //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let chatPostParams = [
            "text": text,
        ]
        
        //URLオブジェクトの生成
        let number = indexRowDictionaryId!
        print(number)
        let url = URL(string: "https://teachapi.herokuapp.com/chatrooms/\(number)/messages")!
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //ボディーを付与（2つめの辞書）
        let parameter = ["message_params": chatPostParams]
        
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
//                    self.tableView.reloadData()
                }
                
            } catch{
                
            }
            
        }
        task.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //キーボードを閉じる
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
    }
}

class CustomChatTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = 30 // ここ変える
        self.borderStyle = .none
        self.layer.cornerRadius = 10
    }
}

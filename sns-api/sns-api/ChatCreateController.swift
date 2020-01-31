//
//  ChatCreateController.swift
//  sns-api
//
//  Created by saya on 2020/02/01.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ChatCreateController: UIViewController {
    
    @IBOutlet weak var chatName: CustomPostTextField!
    @IBAction func chatroomCreate(_ sender: UIButton) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        let name = chatName.text //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let chatNameParams = [
            "name": name
        ]
        
        //URLオブジェクトの生成
        let url = URL(string: "https://teachapi.herokuapp.com/chatrooms")!
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //ボディーを付与（2つめの辞書）
        let parameter = ["chatroom_params": chatNameParams]
        
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
                print("チャットルームができたよ〜")
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
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

class CustomChatNameTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.height = 50 // ここ変える
        self.borderStyle = .none
    }
}

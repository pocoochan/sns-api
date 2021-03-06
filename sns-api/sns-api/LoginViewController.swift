//
//  LoginViewController.swift
//  sns-api
//
//  Created by saya on 2020/01/17.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var signInEmail: UITextField!
    @IBOutlet weak var signInPassword: UITextField!
    @IBOutlet weak var signInPassWordConfirmation: UITextField!
    @IBAction func signIn(_ sender: Any) {

         let config: URLSessionConfiguration = URLSessionConfiguration.default
                 
                let session: URLSession = URLSession(configuration: config)
                 
                //テキストフィールドに入力されたStringと取得して変数にいれる
                let email = signInEmail.text
                let password = signInPassword.text
                let passwordConfirmation = signInPassWordConfirmation.text
                
                //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
                let signInParams = [
                    "email": email,
                    "password": password,
                    "passwordConfirmation": passwordConfirmation
                       ]
                 
                //URLオブジェクトの生成
                 let url = URL(string: "https://teachapi.herokuapp.com/sign_in")!
                //URLRequestの生成
                 var req: URLRequest = URLRequest(url: url)
                 req.httpMethod = "POST"
                
                //ヘッダーを付与
                 req.setValue("application/json", forHTTPHeaderField: "Content-Type")

                //ボディーを付与（2つめの辞書）
                let parameter = ["sign_in_user_params": signInParams]
                
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
                        
                        //辞書からtokenを取り出す
                        let tokenValue = response["token"]
                        let idValue = response["id"]
                        let nameValue = response["name"]
                        let bioValue = response["bio"]
                        print(tokenValue!)
                        
                        //取り出したtokenをユーザーデフォルトに保存する
                        let defaults = UserDefaults.standard
                        defaults.set(tokenValue!, forKey: "responseToken")
                        defaults.set(idValue!, forKey: "responseId")
                        defaults.set(nameValue!, forKey: "responseName")
                        defaults.set(bioValue!, forKey: "responseBio")
                        print("ユーザーデフォルトにtokenとidを保存したよ")
                        print(defaults)
                        print(defaults.string(forKey: "responseName"))
                        
                         
                         DispatchQueue.main.async {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let MyPageController = storyboard.instantiateViewController(withIdentifier: "MyPageController")
                            self.navigationController?.pushViewController(MyPageController, animated: true)
//                            self.present(MyPageController, animated: true, completion: nil)
                            print("マイページへの画面遷移成功だよ")
                         }
                         
                     } catch{
                         
                     }
                     
                 }
                 task.resume()
        
    }
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
}

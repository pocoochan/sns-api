//
//  ViewController.swift
//  sns-api
//
//  Created by saya on 2020/01/17.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myNaviBar: UINavigationBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myName: UITextField!
    @IBOutlet weak var myBio: UITextField!
    @IBOutlet weak var myEmail: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myPassWordConfirmation: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
//        var city: String = ""
//        city = textfield.text!
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
         
        let session: URLSession = URLSession(configuration: config)
         
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let name = myName.text
        let bio = myBio.text
        let email = myEmail.text
        let password = myPassword.text
        let passwordConfirmation = myPassWordConfirmation.text
        
        //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let signUpParams = [
            "name": name,
            "bio": bio,
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation
               ]
         
        //URLオブジェクトの生成
         let url = URL(string: "https://teachapi.herokuapp.com/sign_up")!
        //URLRequestの生成
         var req: URLRequest = URLRequest(url: url)
         req.httpMethod = "POST"
        
        //ヘッダーを付与
         req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        //ボディーを付与（2つめの辞書）
        let parameter = ["sign_up_user_params": signUpParams]
        
        req.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
//         2重の辞書にした。2重の辞書でばーちーさんがAPIを作ったから。
//         "sign_in_user_params": {
//                      "email": "email",
//                      "password": "password",
//                      "password_confirmation": "pass"
//                    }
//         Swiftでは、””：”” は辞書の形。
        

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


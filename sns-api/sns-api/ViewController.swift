//
//  ViewController.swift
//  sns-api
//
//  Created by saya on 2020/01/17.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var myNaviBar: UINavigationBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myName: UITextField!
    @IBOutlet weak var myBio: UITextField!
    @IBOutlet weak var myEmail: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myPassWordConfirmation: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
    
    
    @IBAction func loginButton(_ sender: Any) {
        DispatchQueue.main.async {
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
           self.navigationController?.pushViewController(loginViewController, animated: true)
           //self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
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
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    self.navigationController?.pushViewController(loginViewController, animated: true)
                    //self.present(loginViewController, animated: true, completion: nil)
                 }
                 
             } catch{
                 
             }
             
         }
         task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンの装飾
        let rgba = UIColor(red: 235/255, green: 105/255, blue: 122/255, alpha: 1.0)
        signUp.backgroundColor = rgba
        signUp.layer.cornerRadius = 10.0
//        login.setTitleColor(UIColor = rgba, for: UIControl.State.normal)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 235/255, green: 105/255, blue: 122/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [
        .foregroundColor: UIColor(red: 46/255, green: 48/255, blue: 49/255, alpha: 1.0)
        ]
        
//        self.navigationItem.titleView = UIImageView(image:UIImage(named:"navBar"))

        
        //タブバー
//        let tabBarController = UITabBarController()
//
//        let viewController1 = UIViewController()
////        viewController1.瀬tV家wCオンtロッェr(MyPageController, animated: false)
//        //ナビゲーションバーを追加
////        let navigationController1 = UINavigationController(rootViewController: viewController1)
//        
//        //タブバーにしたい画面を配列形式にする
//        let viewController2 = UIViewController()
//        let viewController3 = UIViewController()
//        tabBarController.setViewControllers([viewController1, viewController2, viewController3], animated: true)
//
//        navigationController?.pushViewController(tabBarController, animated: true)
        // Do any additional setup after loading the view.
    }


}


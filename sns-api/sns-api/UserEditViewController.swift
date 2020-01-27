//
//  UserEditViewController.swift
//  sns-api
//
//  Created by saya on 2020/01/18.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController {
    
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editBio: UITextField!
    
    //ユーザー情報編集
    @IBAction func userEditSave(_ sender: Any) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let name = editName.text
        let bio = editBio.text
        
        //その変数たちを集めた変数をつくって、それをJSON形式でボディに付与する（1つめの辞書）
        let userEditParams = [
            "name": name,
            "bio": bio
        ]
        
        //URLオブジェクトの生成
        let defaults = UserDefaults.standard
        let myId = defaults.string(forKey: "responseId")!
        print(myId)
        let url = URL(string: "https://teachapi.herokuapp.com/users/\(myId)")!
        //URLRequestの生成atal error: Unexpectedly f
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "PUT"
        
        //ヘッダーを付与
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //ボディーを付与（2つめの辞書）
        let parameter = ["user_params": userEditParams]
        
        req.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        
        print(String(data: req.httpBody!, encoding: .utf8))
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            print(data)
            print(response)
            print(error)
            
            let responseString: String =  String(data: data!, encoding: .utf8)!
            print(responseString)
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print(response)
                
                let nameValue = response["name"]
                let bioValue = response["bio"]
                print("\(nameValue!)\(bioValue!)に変更されたよ")
                
                
//                DispatchQueue.main.async {
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
    
    //ユーザー削除ボタン

    
    @IBAction func userDelete(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "本当にアカウントを削除しますか？"
        alert.message = ""
        
        alert.addAction(
            UIAlertAction(
                title: "削除します",
                style: .destructive,
                handler: {(action) -> Void in
                    let config: URLSessionConfiguration = URLSessionConfiguration.default
                    
                    let session: URLSession = URLSession(configuration: config)
                    
                    //URLオブジェクトの生成
                    let defaults = UserDefaults.standard
                    let myId = defaults.string(forKey: "responseId")!
                    print(myId)
                    let url = URL(string: "https://teachapi.herokuapp.com/users/\(myId)")!
                    //URLRequestの生成
                    var req: URLRequest = URLRequest(url: url)
                    req.httpMethod = "DELETE"
                    
                    //ヘッダーを付与
                    let myToken = defaults.string(forKey: "responseToken")!
                    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
                    
                    //APIを呼ぶよ
                    let task = session.dataTask(with: req){(data, response, error) in
                        
                        
                        do {
                            let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                            
                            print(response)
                            
                            print("ユーザー削除されたよ")
                            
                            
                            //                            DispatchQueue.main.async {
                            //                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //                                let ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
                            //                                self.navigationController?.pushViewController(ViewController, animated: true)
                            //                                print("ユーザーが削除されてサインインページに遷移したよ")
                            //                            }
                            
                            
                        } catch{
                            
                        }
                        
                    }
                    task.resume()
            })
        )
        
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: nil)
        )
        
        self.present(
            alert,
            animated: true,
            completion: {
                print("アラートが表示された〜")
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //入力フォームにj初期値で現在の名前、自己紹介を表示させる
        let defaults = UserDefaults.standard
        editName.placeholder = defaults.string(forKey: "responseName")
        editBio.placeholder = defaults.string(forKey: "responseBio")
        
        //ナビバーの色を変えたい
//        self.navigationController!.navigationBar.barStyle = .default
//        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 38/255, green: 192/255, blue: 184/255, alpha: 1.0)
//        self.navigationController!.navigationBar.tintColor = .white
//        self.navigationController!.navigationBar.titleTextAttributes = [
//            .foregroundColor: UIColor.white
//        ]

       
    }
}

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
                
//                DispatchQueue.main.async {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
//                    self.navigationController?.pushViewController(ViewController, animated: true)
//                    print("ユーザーが削除されてサインインページに遷移したよ")
//                }
                
                
            } catch{
                
            }
            
        }
        task.resume()
    }
    //ここからスイッチを試す
    @IBOutlet weak var mySwitch1: UISwitch!
    @IBOutlet weak var mySwitch2: UISwitch!
    
    @IBAction func saveStatus(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(mySwitch1.isOn, forKey: "switchOn")
        print("保存完了したよ")
    }
    
    //ログインボタンを押した瞬間にUserデフォルト参照する
    @IBAction func readStatus(_ sender: Any) {
        let defaults = UserDefaults.standard
        mySwitch2.isOn = defaults.bool(forKey: "switchOn")
        //ここはset
        print("myswitch2の値は\(mySwitch2.isOn)です")
        //ここはget isOnはgetでもsetでも両方つかえるよ。別れているのもあるよ。
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

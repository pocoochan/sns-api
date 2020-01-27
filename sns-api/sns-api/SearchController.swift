//
//  testController.swift
//  sns-api
//
//  Created by saya on 2020/01/18.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    var response: [[String: Any]]?
    
    @IBOutlet weak var searchPage: UITextField!
    @IBOutlet weak var searchLimit: UITextField!
    @IBOutlet weak var searchQuery: UITextField!
    
    @IBAction func searchButton(_ sender: Any) {
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let page = searchPage.text
        let limit = searchLimit.text
        let query = searchQuery.text
        
        //URLを組み立てている
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/users"
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "query", value: query)
        ]
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "GET"

        
        print(url)
            
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in

            
            
            do {
                let response: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                
                self.response = response
                print(response)
                

                
            } catch{
                
            }
            
        }
        task.resume()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBOutlet weak var followId: UITextField!
    @IBAction func follow(_ sender: Any) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let id = followId.text!
        
        //URLオブジェクトの生成
        let defaults = UserDefaults.standard
        let url = URL(string:"https://teachapi.herokuapp.com/users/\(id)/follow")!
        print(url)
        print(id)
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        
        //ヘッダーを付与
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            print(data)
            print(error)
            
            let responseString: String =  String(data: data!, encoding: .utf8)!
            print(responseString)
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("フォロー完了")
                
                
            } catch{
                
            }
            
        }
        task.resume()
    }
    

    @IBOutlet weak var unFollow: UITextField!
    @IBAction func unFollow(_ sender: Any) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        let id = unFollow.text!
        
        //URLオブジェクトの生成
        let defaults = UserDefaults.standard
        let url = URL(string:"https://teachapi.herokuapp.com/users/\(id)/follow")!
        print(url)
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "DELETE"
        
        //ヘッダーを付与
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            print(data)
            print(error)
            
            let responseString: String =  String(data: data!, encoding: .utf8)!
            print(responseString)
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("フォロー解除")
                
                
            } catch{
                
            }
            
        }
        task.resume()
    }
    
    

}

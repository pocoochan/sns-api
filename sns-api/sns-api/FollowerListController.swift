//
//  FollowerList.swift
//  sns-api
//
//  Created by saya on 2020/02/04.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class FollowerListController: UITableViewController {

    var response: [[String: Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 私がフォロー中のユーザー一覧をよぶAPI
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        //               let page = searchPage.text
        //               let limit = searchLimit.text
        //               let query = searchQuery.text
        
        //URLを組み立てている
        let defaults = UserDefaults.standard
        let number = defaults.string(forKey: "responseId")!
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/users/\(number)/followers"
        urlComponents.queryItems = [
            //                   URLQueryItem(name: "page", value: page),
            //                   URLQueryItem(name: "limit", value: limit),
            //                   URLQueryItem(name: "query", value: query)
        ]
        
        let url: URL = urlComponents.url!
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "GET"
        
        
        print(url)
        
        //ヘッダーを付与
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            
            
            
            do {
                let response: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                
                print(response)
                self.response = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

                
            } catch{
                
            }
            
        }
        task.resume()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 235/255, green: 105/255, blue: 122/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 46/255, green: 48/255, blue: 49/255, alpha: 1.0)
        ]
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "FollowerListCustomCell"
        if let myCell: FollowerListCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FollowerListCustomCell {
            myCell.userIcon?.image = UIImage(named: "defaultIcon")
            myCell.userName?.text = response?[indexPath.row]["name"] as? String
            myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
            myCell.userIcon?.layer.cornerRadius = 35
            myCell.followBackButton?.addTarget(self, action: #selector(followBackButtonPush), for: .touchUpInside)
            //タグを設定
            myCell.followBackButton?.tag = indexPath.row
            return myCell
        }
        
        let myCell = FollowerListCustomCell(style: .default, reuseIdentifier: "FollowerListCustomCell")
        myCell.userIcon?.image = UIImage(named: "defaultIcon")
        myCell.userName?.text = response?[indexPath.row]["name"] as? String
        myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
        myCell.userIcon?.layer.cornerRadius = 35
//        myCell.unFollowButton?.addTarget(self, action: #selector(unFollow), for: .touchUpInside)
//        //タグを設定
//        myCell.unFollowButton?.tag = indexPath.row
        return myCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = response {
            return response.count
        }
        return 0
    }
    
    //1つ1つのセルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(107)
    }

    @IBAction func followBackButtonPush(_ sender: Any) {
        (sender as AnyObject).setTitle("フォロー中", for: .normal)
        (sender as AnyObject).setTitleColor(.gray, for: .normal)
        
        print([(sender as AnyObject).tag!])
        print("\([(sender as AnyObject).tag!])番目の行が選択されました")
        print("ここにindexPath.rowばんめの辞書をそのまま出したい")
        let indexRowDictionary = (response?[(sender as AnyObject).tag!])!
        print(indexRowDictionary)
        let indexRowDictionaryId = indexRowDictionary["id"]!
        print(indexRowDictionaryId)
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        let id = indexRowDictionaryId
        
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
    
    
}

class FollowerListCustomCell: UITableViewCell {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var followBackButton: UIButton!
}

//
//  MyFollowListController.swift
//  sns-api
//
//  Created by saya on 2020/02/01.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class MyFollowListController: UITableViewController {
    
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
        urlComponents.path = "/users/\(number)/followings"
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
        
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 46/255, green: 48/255, blue: 49/255, alpha: 1.0)
        ]
        
        
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "MyFollowListCustomCell"
        if let myCell: MyFollowListCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyFollowListCustomCell {
            myCell.userIcon?.image = UIImage(named: "defaultIcon")
//            myCell.userName?.text = response?[indexPath.row]["name"] as? String
//            myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
            myCell.userIcon.layer.cornerRadius = 35
//            myCell.followButton.addTarget(self, action: #selector(follow), for: .touchUpInside)
            //タグを設定
//            myCell.followButton.tag = indexPath.row
            return myCell
        }
        
        let myCell = MyFollowListCustomCell(style: .default, reuseIdentifier: "MyFollowListCustomCell")
        myCell.userIcon?.image = UIImage(named: "defaultIcon")
//        myCell.userName?.text = response?[indexPath.row]["name"] as? String
//        myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
        myCell.userIcon.layer.cornerRadius = 35
//        myCell.followButton.addTarget(self, action: #selector(follow), for: .touchUpInside)
        //タグを設定
//        myCell.followButton.tag = indexPath.row
        return myCell
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//       if let response = response {
//           return response.count
//       }
//       return 0
//    }

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


    
    @IBAction func unFollow(_ sender: Any) {
    }
}

class MyFollowListCustomCell: UITableViewCell {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    
}

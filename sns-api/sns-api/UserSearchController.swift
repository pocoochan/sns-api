//
//  UserSearchController.swift
//  sns-api
//
//  Created by saya on 2020/01/27.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class UserSearchController: UITableViewController {
    
     var response: [[String: Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ユーザー一覧をよぶAPI
        let config: URLSessionConfiguration = URLSessionConfiguration.default
               
               let session: URLSession = URLSession(configuration: config)
               
               //テキストフィールドに入力されたStringと取得して変数にいれる
//               let page = searchPage.text
//               let limit = searchLimit.text
//               let query = searchQuery.text
               
               //URLを組み立てている
               var urlComponents = URLComponents()
               urlComponents.scheme = "https"
               urlComponents.host = "teachapi.herokuapp.com"
               urlComponents.path = "/users"
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
               let defaults = UserDefaults.standard
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

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let image:UIImage = UIImage(named:"defaultIcon")!
        //        let resizeImage = image.resized(toWidth: 50)
        
        
        let cellIdentifier: String = "UserSearchCustomCell"
        if let myCell: UserSearchCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? UserSearchCustomCell {
            //            myCell.userProfileIcon?.image = UIImage(named: self.userPhotos[].randomElement()!)
            myCell.userIcon?.image = UIImage(named: "defaultIcon")
            myCell.userName?.text = response?[indexPath.row]["name"] as? String
            myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
            myCell.userIcon.layer.cornerRadius = 35
            return myCell
        }
        
        let myCell = UserSearchCustomCell(style: .default, reuseIdentifier: "UserSearchCustomCell")
        //        myCell.userProfileIcon?.image = resizeImage
        myCell.userIcon?.image = UIImage(named: "defaultIcon")
        myCell.userName?.text = response?[indexPath.row]["name"] as? String
        myCell.userBio?.text = response?[indexPath.row]["bio"] as? String
        myCell.userIcon.layer.cornerRadius = 35
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


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番目の行が選択されました")
        print("ここにindexPath.rowばんめの辞書をそのまま出したい")
        let indexRowDictionary = (response?[indexPath.row])!
        print(indexRowDictionary)
        let indexRowDictionaryId = indexRowDictionary["id"]!
        print(indexRowDictionaryId)
        
        //セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
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
                print("フォロー中という表示にかえたい")
                
                
            } catch{
                
            }
            
        }
        task.resume()
        
        
    }
    @IBAction func follow(_ sender: Any) {
//        func changeButtonText() {
//            followButton.setTitle("フォロー中", for: .normal)
//        }
        
    }
    
}

class UserSearchCustomCell: UITableViewCell {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
}

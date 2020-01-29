//
//  ChatroomController.swift
//  sns-api
//
//  Created by saya on 2020/01/22.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class ChatroomController: UITableViewController {
    
    /*
     チャットルーム一覧を取得するAPI
     */
    var response: [[String: Any]]?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // searchBarのプレースホルダー
        searchController.searchBar.placeholder = "検索したい文字列を入力してください"
        
        // searchBarフォーカス時に背景色を暗くするか？
        searchController.obscuresBackgroundDuringPresentation = true
        
        // searchBarのスタイル
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        
        // searchbarのサイズを調整
        searchController.searchBar.sizeToFit()
        
        // tableViewのヘッダーにsearchController.searchBarをセット
        tableView.tableHeaderView = searchController.searchBar
        
        //APIと通信
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        
        //テキストフィールドに入力[]されたStringと取得して変数にいれる
        //        let page = searchPage.text
        //        let limit = searchLimit.text
        //        let query = searchQuery.text
        
        //URLを組み立てている
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/chatrooms"
        urlComponents.queryItems = [
            //            URLQueryItem(name: "page", value: page),
            //            URLQueryItem(name: "limit", value: limit),
            //            URLQueryItem(name: "query", value: query)
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
        
        self.navigationController!.navigationBar.titleTextAttributes = [
               .foregroundColor: UIColor(red: 46/255, green: 48/255, blue: 49/255, alpha: 1.0)
               ]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "MyCustomCell"
        if let myCell: MyCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyCustomCell {
            myCell.sumpleImage.image = UIImage(named: self.userPhotos[indexPath.row])
//            myCell.sumpleImage.layer.cornerRadius = 50
            myCell.chatroomName?.text = response?[indexPath.row]["name"] as? String
            //myCell.detailTextLabel?.text = response?[indexPath.row]["created_at"] as? String
            myCell.chatroomName?.numberOfLines = 0
            myCell.sumpleImage.layer.cornerRadius = 20
            return myCell
        }
        
        let myCell = MyCustomCell(style: .default, reuseIdentifier: "MyCustomCell")
        myCell.sumpleImage.image = UIImage(named: self.userPhotos[indexPath.row])
//        myCell.sumpleImage.layer.cornerRadius = 50
        myCell.chatroomName?.text = response?[indexPath.row]["name"] as? String
        // myCell.detailTextLabel?.text = response?[indexPath.row]["created_at"] as? String
        myCell.chatroomName?.numberOfLines = 0
        myCell.sumpleImage.layer.cornerRadius = 20
        return myCell
    }
    
    //生成するセルの個数
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //アクション実装
        print("\(indexPath.row)番目の行が選択されました")
        print("ここにindexPath.rowばんめの辞書をそのまま出したい")
        let indexRowDictionary = (response?[indexPath.row])!
        print(indexRowDictionary)
        let indexRowDictionaryId = indexRowDictionary["id"]!
        print(indexRowDictionaryId)
        //それを関数にいれる。その関数からIDを取得する。
        //タップされたら、インデックス取得、辞書す取得、ID取得。タップされた時点で画面遷移、API
        //レスポンスが返ってきているのはdidroad。画面を開いた瞬間。
        
        
        //セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        
         /*
         チャット参加API
         */
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //URLオブジェクトの生成
        let number = indexRowDictionaryId
        print(number)
        let url = URL(string: "https://teachapi.herokuapp.com/chatrooms/\(number)/join")!
        //URLRequestの生成
        var req: URLRequest = URLRequest(url: url)
        req.httpMethod = "POST"
        
        //ヘッダーを付与
        let defaults = UserDefaults.standard
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            //            print(data)
            //            print(error)
            
            let responseString: String =  String(data: data!, encoding: .utf8)!
            print(responseString)
            
            
            do {
                let response: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print(response)
                
                //取得したチャットIDを保存する
                let defaults = UserDefaults.standard
                defaults.set(indexRowDictionaryId, forKey: "chatroomId")
                 print("ユーザーデフォルトにチャットidを保存したよ")
                 print(defaults.string(forKey: "chatroomId")!)
                
                
                //        別の画面に遷移
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let IndividualChatController = storyboard.instantiateViewController(withIdentifier: "IndividualChatController")
                    self.navigationController?.pushViewController(IndividualChatController, animated: true)
//                    self.present(IndividualChatController, animated: true, completion: nil)
                    print("チャットルームへの画面遷移成功だよ")
                }
                
            } catch{
                
            }
            
        }
        task.resume()
        
        


    }
    var userPhotos = ["1","2","3","4","5","6","7","8","9","10"]

}

class MyCustomCell: UITableViewCell {
    @IBOutlet weak var chatroomName: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var sumpleImage: UIImageView!
}

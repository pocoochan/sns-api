//
//  IndividualChatController.swift
//  sns-api
//
//  Created by saya on 2020/01/23.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class IndividualChatController: UITableViewController {
    
    var response: [[String: Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         チャットメッセージ一覧を取得するAPI
         */
        //APIと通信
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //URLを組み立てている
        
        let defaults = UserDefaults.standard
        let number = defaults.string(forKey: "chatroomId")!
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/chatrooms/\(number)/messages"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "1")
            //            URLQueryItem(name: "limit", value: limit),
            //            URLQueryItem(name: "query", value: query)
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
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "MyChatCustomCell"
        if let myCell: MyChatCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyChatCustomCell {
            myCell.plofileIcon?.image = UIImage(named: "defaultIcon")
            myCell.chatUserName?.text = (response?[indexPath.row]["user"] as? [String:Any])?["name"] as? String
            myCell.chatMessage?.text = response?[indexPath.row]["text"] as? String
            myCell.chatPostTime?.text = (response?[indexPath.row]["user"] as? [String:Any])?["created_at"] as? String
            myCell.plofileIcon.layer.cornerRadius = 35
            return myCell
        }
        
        let myCell = MyChatCustomCell(style: .default, reuseIdentifier: "MyChatCustomCell")
       myCell.plofileIcon?.image = UIImage(named: "defaultIcon")
        myCell.chatUserName?.text = (response?[indexPath.row]["user"] as? [String:Any])?["name"] as? String
        myCell.chatMessage?.text = response?[indexPath.row]["text"] as? String
        myCell.chatPostTime?.text = (response?[indexPath.row]["user"] as? [String:Any])?["created_at"] as? String
        myCell.plofileIcon.layer.cornerRadius = 35
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
    
}


class MyChatCustomCell: UITableViewCell {
    @IBOutlet weak var plofileIcon: UIImageView!
    @IBOutlet weak var chatUserName: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var chatPostTime: UILabel!
}

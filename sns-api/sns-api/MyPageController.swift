//
//  MyPageController.swift
//  sns-api
//
//  Created by saya on 2020/01/17.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class MyPageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var response: [[String: Any]]?
    
    @IBAction func gotoUserEditViewController(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let UserEditViewController = storyboard.instantiateViewController(withIdentifier: "UserEditViewController")
            self.present(UserEditViewController, animated: true, completion: nil)
            print("画面遷移成功してるよ")
        }
    }
    @IBAction func gotoPostController(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let postController = storyboard.instantiateViewController(withIdentifier: "postController")
            self.present(postController, animated: true, completion: nil)
            print("ツイート作成画面に遷移成功してるよ")
        }
    }
        
    @IBAction func gotoTimeline(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let AllTimelineController = storyboard.instantiateViewController(withIdentifier: "AllTimelineController")
            self.navigationController?.pushViewController(AllTimelineController, animated: true)
//            self.present(AllTimelineController, animated: true, completion: nil)
            print("タイムラインに遷移成功してるよ")
        }
    }
    @IBOutlet weak var myName: UITextView!
    @IBOutlet weak var myBio: UITextView!
    
    
    //    画面に遷移するたびに読み込まれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session: URLSession = URLSession(configuration: config)
        
        //テキストフィールドに入力されたStringと取得して変数にいれる
        //        let page = searchPage.text
        //        let limit = searchLimit.text
        //        let query = searchQuery.text
        
        //URLを組み立てている
        let defaults = UserDefaults.standard
        let myId = defaults.string(forKey: "responseId")!
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "teachapi.herokuapp.com"
        urlComponents.path = "/users/\(myId)/timeline"
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
        let myToken = defaults.string(forKey: "responseToken")!
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer " + myToken, forHTTPHeaderField: "Authorization")
        
        
        //APIを呼ぶよ
        let task = session.dataTask(with: req){(data, response, error) in
            
            do {
                let response: [[String: Any]] = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                
                print(response)
                self.response = response
                //                DispatchQueue.main.async {
                //                    self.tableView.reloadData()
                //                }
                //
            } catch{
                
            }
        }
        task.resume()
    }
    

    @IBOutlet weak var myTV: UITableView!
    
//カスタムセルの作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cellIdentifier: String = "myPageCustomCell"
    if let myCell: myPageCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? myPageCustomCell {

        myCell.userIcon?.image = UIImage(named: "defaultIcon")
        myCell.myUserName?.text = response?[indexPath.row](["user"] as! [String:Any])["name"]
        myCell.myPost?.text = response?[indexPath.row]["text"] as? String
        myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
        myCell.userIcon.layer.cornerRadius = 50
        return myCell
    }
    
    let myCell = myPageCustomCell(style: .default, reuseIdentifier: "myPageCustomCell")
        myCell.userIcon?.image = UIImage(named: "defaultIcon")
        myCell.myUserName?.text = response?[indexPath.row](["user"] as! [String:Any])["name"]
        myCell.myPost?.text = response?[indexPath.row]["text"] as? String
        myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
        myCell.userIcon.layer.cornerRadius = 50
        return myCell
    }
    
    //生成するセルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = response {
            return response.count
        }
        return 0
    }
    
    //1つ1つのセルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(107)
    }
    
    
    override func viewDidLoad() {
        
        myTV.delegate = self
        myTV.dataSource = self
       
        
        super.viewDidLoad()
        
        //マイページに名前と自己紹介を表示させる
        let defaults = UserDefaults.standard
        myName.text = defaults.string(forKey: "responseName")
        myBio.text = defaults.string(forKey: "responseBio")
    }
    

    //
    //    //画面をはなれてるときに読み込まれる
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //
    //    }

}

class myPageCustomCell: UITableViewCell{
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var myUserName: UILabel!
    @IBOutlet weak var myPost: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postEdit: UIButton!
}


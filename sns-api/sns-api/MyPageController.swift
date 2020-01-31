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
    
    @IBOutlet weak var plofileIcon: UIImageView!
    @IBOutlet weak var plofileName: UILabel!
    @IBOutlet weak var plofileBio: UILabel!
    
    override func viewDidLoad() {
        
        myTV.delegate = self
        myTV.dataSource = self
       
        
        super.viewDidLoad()
        
        //マイページに名前と自己紹介を表示させる
        let defaults = UserDefaults.standard
        plofileIcon.image = UIImage(named: "defaultIcon")
        plofileIcon.layer.cornerRadius = 35
        plofileName.text = defaults.string(forKey: "responseName")!
        plofileBio.text = defaults.string(forKey: "responseBio")!
    }
    
    
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
                    DispatchQueue.main.async {
                        self.myTV.reloadData()
                    }
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
        //↓こちらでnameを取り出したいです。
        myCell.myUserName?.text = (response?[indexPath.row]["user"] as? [String:Any])?["name"] as? String
        myCell.myPost?.text = response?[indexPath.row]["text"] as? String
        myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
        myCell.userIcon.layer.cornerRadius = 35
        myCell.postEditButton.addTarget(self, action: #selector(postEditButton(_:)), for: .touchUpInside)
        //タグを設定
        myCell.postEditButton.tag = indexPath.row
        return myCell
    }
    
    let myCell = myPageCustomCell(style: .default, reuseIdentifier: "myPageCustomCell")
        myCell.userIcon?.image = UIImage(named: "defaultIcon")
        myCell.myUserName?.text = (response?[indexPath.row]["user"] as? [String:Any])?["name"] as? String
        myCell.myPost?.text = response?[indexPath.row]["text"] as? String
        myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
        myCell.userIcon.layer.cornerRadius = 35
        myCell.postEditButton.addTarget(self, action: #selector(postEditButton(_:)), for: .touchUpInside)
        //タグを設定
        myCell.postEditButton.tag = indexPath.row
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
    
    


    
        //画面をはなれてるときに読み込まれる
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        }

    @IBAction func postEditButton(_ sender: Any) {
//        let modalViewController = ModalViewController()
//        modalViewController.modalPresentationStyle = .custom
//        modalViewController.transitioningDelegate = self
//        present(modalViewController, animated: true, completion: nil)
        
    }
}

class myPageCustomCell: UITableViewCell{
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var myUserName: UILabel!
    @IBOutlet weak var myPost: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postEditButton: UIButton!
}



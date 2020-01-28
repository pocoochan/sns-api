//
//  AllTimelineController.swift
//  sns-api
//
//  Created by saya on 2020/01/20.
//  Copyright © 2020 saya. All rights reserved.
//

import UIKit

class AllTimelineController: UITableViewController {
    
    var response: [[String: Any]]?
    var userPhotos = ["defaultIcon1","defaultIcon2","defaultIcon3","defaultIcon4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /*
         すべてのタイムラインを取得するAPI
         */
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
        urlComponents.path = "/posts"
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
        
    }
    
    /*
     APIで取得したデータをテーブルビューに表示させるよ
     */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let image:UIImage = UIImage(named:"defaultIcon")!
//        let resizeImage = image.resized(toWidth: 50)
        
        let random_userPhotos = self.userPhotos.randomElement()
        
        let cellIdentifier: String = "AllTimelineCustomCell"
        if let myCell: AllTimelineCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AllTimelineCustomCell {
//            myCell.userProfileIcon?.image = UIImage(named: self.userPhotos[].randomElement()!)
            myCell.userProfileIcon?.image = UIImage(named: random_userPhotos!)
//            myCell.userProfileName?.text = response?[indexPath.row](["user"] as! [String:Any])["name"]
            myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
            myCell.userProfileIcon.layer.cornerRadius = 35
            return myCell
            
        }
        
        let myCell = AllTimelineCustomCell(style: .default, reuseIdentifier: "AllTimelineCustomCell")
//        myCell.userProfileIcon?.image = resizeImage
        myCell.userProfileIcon?.image = UIImage(named: random_userPhotos!)
        myCell.userProfileName?.text = response?[indexPath.row]["text"] as? String
        myCell.postDate?.text = response?[indexPath.row]["created_at"] as? String
         myCell.userProfileIcon.layer.cornerRadius = 35
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
    
}


class AllTimelineCustomCell: UITableViewCell {
    @IBOutlet weak var userProfileIcon: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
    @IBOutlet weak var postDate: UILabel!
}


extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
   
}


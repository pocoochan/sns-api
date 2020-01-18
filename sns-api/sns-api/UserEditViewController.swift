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
    
    @IBAction func userEditSave(_ sender: Any) {
        
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

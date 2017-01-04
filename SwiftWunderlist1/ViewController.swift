//
//  ViewController.swift
//  SwiftWunderlist1
//
//  Created by kikuchi wataru on 2017/01/04.
//  Copyright © 2017年 kikuchi wataru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var backImageVIew: UIImageView!
    
    
    @IBOutlet weak var backView: UIView!
    
    //配列
    var titleArray = [String]()
    
    var label:UILabel = UILabel()
    
    //選択されたセルの番号を入れる
    var count:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        textField.delegate = self
        
        backView.layer.cornerRadius = 10.0
        
        table.separatorStyle = .none
     
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        //配列の中に文字を入れる
        titleArray.append(textField.text!)
        
        //配列をアプリ保存する
        UserDefaults.standard.set(titleArray, forKey: "array")
        
        if (UserDefaults.standard.object(forKey: "array") != nil){
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            textField.text = ""
            
            table.reloadData()
            
        }
        
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から出す
        if (UserDefaults.standard.object(forKey: "array") != nil){
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
        }
        
        
        if(UserDefaults.standard.object(forKey: "image") != nil){
            
            let numberString = UserDefaults.standard.string(forKey: "image")
            
            backImageVIew.image = UIImage(named: numberString! + ".jpg")
            
        }
        
        
        //tableViewをreloadして、デリゲートメソッドを再度呼び出す
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //画面遷移をしたい
        count = Int(indexPath.row)
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "next"){
            let nextVC:NextViewController = segue.destination as! NextViewController
            
            //番号を入れる
            nextVC.selectedNumber = count
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView:UITableView,commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath:IndexPath){
     
        if editingStyle == .delete{
            
            //titleArrayの選択された(スライドされたセル)の番号の配列に入っている文字を消去します
            titleArray.remove(at: indexPath.row)
            
            //配列をアプリ内へ保存する
            UserDefaults.standard.set(titleArray, forKey: "array")
            
            //tableのデリゲートメソッドを呼ぶ→リロードデータ
            table.reloadData()
            
        }
        
        
    }

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}


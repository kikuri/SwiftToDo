//
//  NextViewController.swift
//  SwiftWunderlist1
//
//  Created by kikuchi wataru on 2017/01/04.
//  Copyright © 2017年 kikuchi wataru. All rights reserved.
//

import UIKit
import MessageUI

class NextViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    
    
    //配列
    var titleArray:Array = [String]()
    
    //セルが選択された番号が入ってくる変数
    var selectedNumber:Int = 0
    
    
    @IBOutlet weak var textView: UITextView!
    
    let mailViewController = MFMailComposeViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から取り出す
        if(UserDefaults.standard.object(forKey: "array") != nil){
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            textView.text = titleArray[selectedNumber]
            
            
        }
        
        
        
        //前の画面で選択された番号の文字をtitleArrayから取り出す
        
        
        
        
        //textViewへ反映する
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textView.isFirstResponder){
            //閉じる
            textView.resignFirstResponder()
        }
    }
    
    
    @IBAction func openMail(_ sender: Any) {
        
        //メールを開く
        mailViewController.mailComposeDelegate = self
        
        //本文
        mailViewController.setMessageBody(textView.text, isHTML: false)
        
        //件名
        mailViewController.setSubject("件名")
        
        let mailAddress = ["blueending3@gmail.com"]
        
        //To(誰に送るか)
        mailViewController.setToRecipients(mailAddress)
        
        present(mailViewController, animated: true, completion: nil)
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

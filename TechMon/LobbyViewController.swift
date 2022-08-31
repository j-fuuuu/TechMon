//
//  ViewController.swift
//  TechMon
//
//  Created by 藤井玖光 on 2022/08/31.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    
    let techmonManeger = TechMonManager.shared
    
    var stamina: Int = 100
    var staminaTimer: Timer!
    
    //アプリが起動したときに一度だけ呼ばれる
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //UIの設定
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina) / 100"
        
        //タイマーの設定
        staminaTimer = Timer.scheduledTimer(timeInterval: 3,
                                            target: self,
                                            selector: #selector(updateStaminaValue),
                                            userInfo: nil,
                                            repeats: true)
                                        staminaTimer.fire()
    }
    
    //ロビー画面が見えるようになる時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        techmonManeger.playBGM(fileName: "lobby")
    }
    //ロビー画面が見えなくなる時に呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        techmonManeger.stopBGM()
    }
    
    @IBAction func toBattele(){
        
        //スタミナが50以上あればスタミナ50を消費して戦闘画面へ
        if stamina >= 50 {
            
            stamina -= 50
            staminaLabel.text = "\(stamina)/100"
            performSegue(withIdentifier: "toButtle", sender: nil)
        } else {
            let alert = UIAlertController(
                title: "バトルに行けません",
                message: "スタミナを貯めてください",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    //スタミナの回復
    @objc func updateStaminaValue(){
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina)/100"
        }
    }
    
}


//
//  GameViewController.swift
//  Barabara
//
//  Created by Honoka Nishiyama on 2024/04/30.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var timer: Timer!
    var score: Int = 1000
    var saveData: UserDefaults = UserDefaults.standard
    
//    画像サイズの取得
    let width: CGFloat = UIScreen.main.bounds.size.width
//    ３つの画像のx座標の配列
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
//    ３つの画像の動き幅の配列
    var dx: [CGFloat] = [1.0, 0.5, -1.0]

    override func viewDidLoad() {
        super.viewDidLoad()
//        ３つの画像を画面幅の中心に設定
        positionX = [width/2, width/2, width/2]
//        startメソッドの呼び出し
        self.start()
    }
    
    func start(){
        resultLabel.isHidden = true
//        タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func up(){
        for i in 0..<3 {
//            端に来たら動かす方向を反対にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * -1
            }
//            画像の位置をdx[i]ぶんずらす
            positionX[i] += dx[i]
        }
//        画像をずらした位置に移動する
        imageView1.center.x = positionX[0]
        imageView2.center.x = positionX[1]
        imageView3.center.x = positionX[2]
        
    }
    
    @IBAction func stop(){
//        タイマーが動いている場合
        if timer.isValid == true {
//            タイマーを止める
            timer.invalidate()
        }
        
        for i in 0..<3 {
//            それぞれの画像が中心からどれくらいずれているかをスコアに反映する
            score = score - abs(Int(width/2 - positionX[i]))*2
        }
        
        resultLabel.text = "Score:" + String(score)
        resultLabel.isHidden = false
        
        let highScore1: Int = saveData.integer(forKey: "score1")
        let highScore2: Int = saveData.integer(forKey: "score2")
        let highScore3: Int = saveData.integer(forKey: "score3")
        
//        ハイスコアの更新
        if score > highScore1 {
            saveData.set(score, forKey: "score1")
            saveData.set(highScore1, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore2 {
            saveData.set(score, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore3 {
            saveData.set(score, forKey: "score3")
        }
    }
    
    @IBAction func retry(){
        score = 1000
        //        ３つの画像を画面幅の中心に設定
        positionX = [width/2, width/2, width/2]
        
        if timer.isValid == false {
            self.start()
        }
        
    }
    
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
    }
    

}

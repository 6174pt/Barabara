//
//  RankingViewController.swift
//  Barabara
//
//  Created by Honoka Nishiyama on 2024/04/30.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLabel1: UILabel!
    @IBOutlet var rankingLabel2: UILabel!
    @IBOutlet var rankingLabel3: UILabel!
    
    let saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingLabel1.text = String(saveData.integer(forKey: "score1"))
        rankingLabel2.text = String(saveData.integer(forKey: "score2"))
        rankingLabel3.text = String(saveData.integer(forKey: "score3"))
        
    }
    
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
    }

}

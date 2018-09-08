//
//  StatsViewController.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var statistics: StatsTracker.STATS!
    
    var bestStreak_title: UILabel!
    var bestStreak_value: UILabel!
    
    var recentAttemptsHeader: UILabel!
    
    var recentAttemptsPhotos: [UIImageView] = []
    var recentAttemptsNames: [UILabel] = []
    var recentAttemptsGuesses: [UILabel] = []
    
    var resetStats: UIButton!
    var returnToGame: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        init_labels()
        init_buttons()
        create_question_history()
        
        returnToGame.addTarget(self, action: #selector(return_to_target), for: .touchUpInside)
        
        resetStats.addTarget(self, action: #selector(reset), for: .touchUpInside)
        
    }
    
    @objc func return_to_target(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func reset() {
        var parent = self.navigationController?.viewControllers[1] as! GameScreenController
        parent.stats = StatsTracker.STATS()
        return_to_target()
    }

}

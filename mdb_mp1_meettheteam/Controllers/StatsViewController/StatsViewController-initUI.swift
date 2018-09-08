//
//  StatsViewController-initUI.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

extension StatsViewController {
    
    func init_labels() {
        bestStreak_title = UILabel(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 100))
        bestStreak_title.text = "Best Streak"
        bestStreak_title.textAlignment = .center
        view.addSubview(bestStreak_title)
        
        bestStreak_value = UILabel(frame: CGRect(x: 0, y:110, width: view.frame.width, height: 100))
        bestStreak_value.text = "\(statistics.best_streak)"
        bestStreak_value.font = UIFont(name: "Arial", size: 60)
        bestStreak_value.textAlignment = .center
        view.addSubview(bestStreak_value)
        
        recentAttemptsHeader = UILabel(frame: CGRect(x: 0, y:view.frame.height/4, width: view.frame.width, height: 100))
        recentAttemptsHeader.text = "Recently Answered"
        recentAttemptsHeader.textAlignment = .center
        view.addSubview(recentAttemptsHeader)
        
    }
    
    func init_buttons() {
        returnToGame = UIButton(frame: CGRect(x: 20, y: 40, width: 20, height: 20))
        returnToGame.setImage(UIImage(named: "left-arrow"), for: UIControlState.normal)
        view.addSubview(returnToGame)
        
        resetStats = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height - 80, width: view.frame.width / 2, height: 50))
        resetStats.setTitle("Reset Stats", for: .normal)
        resetStats.backgroundColor = .red
        resetStats.layer.cornerRadius = 20
        view.addSubview(resetStats)
    }
    
    func create_question_history() {
        let questions = statistics.last3
        
        for q_num in 0..<questions.count {
            let reverse_offset = (questions.count-1) - q_num
            
            let record = questions.peek(q_num)
            
            let y_center = view.frame.height/2.2 + (view.frame.width/4 + 20) * CGFloat(reverse_offset)
            
            let curr_image_obj = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: view.frame.width/4))
            curr_image_obj.center = CGPoint(x: view.frame.width/5, y: y_center)
            curr_image_obj.image = record?.img
            curr_image_obj.contentMode = .scaleAspectFill
            curr_image_obj.clipsToBounds = true
            recentAttemptsPhotos.append(curr_image_obj)
            
            
            
            let curr_name_obj = UILabel(frame: CGRect(x: view.frame.width/5 + view.frame.width/8 + 15, y: y_center-40, width: view.frame.width, height: 60))
            curr_name_obj.text = record?.answer
            curr_name_obj.textAlignment = .left
            curr_name_obj.textColor = StyleColors.GREEN
            recentAttemptsNames.append(curr_name_obj)
            
            let curr_guess_obj = UILabel(frame: CGRect(x: view.frame.width/5 + view.frame.width/8 + 15, y: y_center, width: view.frame.width, height: 60))
            curr_guess_obj.text = "You Answered: \(record!.guess)"
            curr_guess_obj.textAlignment = .left
            curr_guess_obj.textColor = StyleColors.RED
            curr_guess_obj.font = UIFont(name: "Arial", size: 13)?.italic
            recentAttemptsGuesses.append(curr_guess_obj)
            
            view.addSubview(curr_image_obj)
            view.addSubview(curr_name_obj)
            view.addSubview(curr_guess_obj)
        }
    }
    
    
    
    
    
}

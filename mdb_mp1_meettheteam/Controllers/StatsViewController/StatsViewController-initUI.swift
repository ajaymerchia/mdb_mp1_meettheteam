//
//  StatsViewController-initUI.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

extension StatsViewController {
    
    
    /// Creates the best streak labels and the header for the recent attempts section
    func init_labels() {
        bestStreak_title = UILabel(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 100))
        bestStreak_title.text = "Best Streak"
        bestStreak_title.textAlignment = .center
        bestStreak_title.font = UIFont(name: "Gentona-Bold", size: 24)
        bestStreak_title.textColor = .white
        view.addSubview(bestStreak_title)
        
        bestStreak_value = UILabel(frame: CGRect(x: 0, y:110, width: view.frame.width, height: 100))
        bestStreak_value.text = "\(statistics.best_streak)"
        bestStreak_value.textColor = .white
        bestStreak_value.font = UIFont(name: "NaughtySquirrelShadowedDemo", size: 60)
        bestStreak_value.textAlignment = .center
        view.addSubview(bestStreak_value)
        
        recentAttemptsHeader = UILabel(frame: CGRect(x: 0, y:view.frame.height/4 - 10, width: view.frame.width, height: 100))
        recentAttemptsHeader.text = "Recently Answered"
        recentAttemptsHeader.font = UIFont(name: "Gentona-Bold", size: 24)
        recentAttemptsHeader.textColor = .white
        recentAttemptsHeader.textAlignment = .center
        view.addSubview(recentAttemptsHeader)
        
    }
    
    
    /// Creates the reset statistics buttons
    func init_buttons() {
        returnToGame = UIButton(frame: CGRect(x: 20, y: 40, width: 20, height: 20))
        returnToGame.setImage(UIImage(named: "left-arrow"), for: UIControlState.normal)
        view.addSubview(returnToGame)
        
        resetStats = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height - 80, width: view.frame.width / 2, height: 50))
        resetStats.setTitle("Reset Stats", for: .normal)
        resetStats.titleLabel?.font = UIFont(name: "Gentona-Bold", size: 24)
        resetStats.setTitleColor(StyleColors.RED, for: .normal)
        resetStats.backgroundColor = .white
        resetStats.layer.cornerRadius = 10
        view.addSubview(resetStats)
    }
    
    
    /// Dynamically creates previous questions and answers based on how many there are. Displays image, answer, and guess, all stored in StatsTracker.RoundResult
    func create_question_history() {
        let questions = statistics.last3
        
        for q_num in 0..<questions.count {
            let reverse_offset = (questions.count-1) - q_num
            
            let record = questions.peek(q_num)
            
            let y_center = view.frame.height/2.3 + (view.frame.width/4 + 25) * CGFloat(reverse_offset)
            let x_off = view.frame.width/5 + view.frame.width/8 + 15
            
            
            let box = CAShapeLayer()
            let PADDING:CGFloat = 7
            let box_offset = view.frame.width/5 - view.frame.width/8
            
            box.path = UIBezierPath(roundedRect: CGRect(x: box_offset - PADDING, y: y_center-view.frame.width/8-PADDING, width: view.frame.width-2*(box_offset-PADDING), height: view.frame.width/4 + 2 * PADDING), cornerRadius: 10).cgPath
            box.fillColor = StyleColors.rgba(255, 255, 255, 0.9).cgColor
            
            view.layer.addSublayer(box)
            
            let curr_image_obj = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/4, height: view.frame.width/4))
            curr_image_obj.center = CGPoint(x: view.frame.width/5, y: y_center)
            curr_image_obj.image = record?.img
            curr_image_obj.contentMode = .scaleAspectFill
            curr_image_obj.clipsToBounds = true
            recentAttemptsPhotos.append(curr_image_obj)
            view.addSubview(curr_image_obj)

            
            
            
            let curr_name_obj = UILabel(frame: CGRect(x: x_off, y: y_center-40, width: view.frame.width-x_off, height: 60))
            curr_name_obj.text = record?.answer
            curr_name_obj.textAlignment = .left
            curr_name_obj.textColor = StyleColors.GREEN
            curr_name_obj.font = UIFont(name: "NaughtySquirrelDemo", size: 24)
            curr_name_obj.adjustsFontSizeToFitWidth = true

            recentAttemptsNames.append(curr_name_obj)
            view.addSubview(curr_name_obj)
            
            if record!.guess != record!.answer {
                let curr_guess_obj = UILabel(frame: CGRect(x: view.frame.width/5 + view.frame.width/8 + 15, y: y_center-20, width: view.frame.width, height: 60))
                curr_guess_obj.text = "You Answered: \(record!.guess)"
                curr_guess_obj.textAlignment = .left
                curr_guess_obj.textColor = StyleColors.RED
                curr_guess_obj.font = UIFont(name: "Gentona-Bold", size: 16)?.italic
                recentAttemptsGuesses.append(curr_guess_obj)
                view.addSubview(curr_guess_obj)

            }
        }
    }
    
    
    
    
    
}

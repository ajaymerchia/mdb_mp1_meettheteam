//
//  GameScreenController-gamelogic.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit


extension GameScreenController {
    @objc func new_question() {
        curr_round = RoundGenerator()
        promptImage.image = curr_round.promptImage
        
        for i in 0..<4 {
            optionButtons[i].setTitle(curr_round.list_of_names[i], for: .normal)
            optionButtons[i].backgroundColor = StyleColors.BLUE
        }
        accepting_input = true
        time_left_in_round = 5
        start_timer()
    }
    
    func start_timer(){
        gameTimer = Timer.scheduledTimer(timeInterval: TIMER_PRECISION, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock(){
        time_left_in_round = time_left_in_round - TIMER_PRECISION
        if time_left_in_round > 0 {
            countDown.text = "\(Int(time_left_in_round)+1)"
        } else {
            time_expired()
        }
    }
    
    func time_expired() {
        accepting_input = false
        gameTimer.invalidate()
        show_answer(harsh: true)
        failed()
        prepare_for_next_question(attempt: "[Time Expired].")
        
        
    }
    
    func failed() {
        countDown.text = get_sad_emoji()
        stats.streak_active = false
        stats.streak = 0
    }
    
    func success() {
        stats.score = stats.score + 1
        stats.streak_active = true
        stats.streak = stats.streak + 1
        if stats.streak > stats.best_streak {
            stats.best_streak = stats.streak
        }
        
    }
    
    func get_sad_emoji() -> String {
        return SAD_EMOJIS[Int(arc4random_uniform(UInt32(SAD_EMOJIS.count)))]
    }
    
    func updateScore(){
        scoreValue.text = "\(stats.score)"
    }
    
    func show_answer(harsh: Bool = false) {
        optionButtons[curr_round.indexOfCorrect].backgroundColor = StyleColors.GREEN
        if harsh {
            for i in 0..<4 {
                if i != curr_round.indexOfCorrect {
                    optionButtons[i].backgroundColor = StyleColors.RED
                }
            }
        }
    }
    
    @objc func process_answer(sender: UIButton){
        if !accepting_input {
            return
        }
        gameTimer.invalidate()
        accepting_input = false
        show_answer()
        if sender.tag != curr_round.indexOfCorrect {
            optionButtons[sender.tag].backgroundColor = StyleColors.RED
            failed()
        } else {
            success()
            updateScore()
        }
        
        prepare_for_next_question(attempt: (sender.titleLabel?.text)!)
    
    }
    
    func prepare_for_next_question(attempt: String){
        stats.last3.enqueue(StatsTracker.RoundResult(img: promptImage.image!, guess: attempt, answer: curr_round.correctName))
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(new_question), userInfo: nil, repeats: false)
    }
    
    func pause_game() {
        stopButton.setTitle("Resume", for: .normal)
        gameTimer.invalidate()
        failed()
        accepting_input = false
        mask_data()
        time_left_in_round = 5
        updateClock()
        curr_state = GAME_STATE.STOPPED
        show_hide_new(false)
        
    }
    
    func mask_data() {
        promptImage.image = UIImage(named: "questionman_blue")
        for i in 0..<4 {
            optionButtons[i].setTitle("", for: .normal)
        }
    }
    
    func resume_game() {
        stopButton.setTitle("Pause", for: .normal)
        gameTimer.invalidate()
        accepting_input = false
        curr_state = GAME_STATE.RUNNING
        new_question()
        show_hide_new(true)
    }
    
    func show_hide_new(_ hideNewGame: Bool) {
        if hideNewGame {
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.newGame.transform = CGAffineTransform(translationX: 0, y: 0)
                self.stopButton.transform = CGAffineTransform(translationX: 0, y: 0)
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.removeNewGame), userInfo: nil, repeats: false)
            })
        } else {
            view.addSubview(newGame)
            view.sendSubview(toBack: newGame)
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.newGame.transform = CGAffineTransform(translationX: 125, y: 0)
                self.stopButton.transform = CGAffineTransform(translationX: -125, y: 0)
            })
        }
    }
    
    @objc func removeNewGame() {
        self.newGame.removeFromSuperview()

    }

}

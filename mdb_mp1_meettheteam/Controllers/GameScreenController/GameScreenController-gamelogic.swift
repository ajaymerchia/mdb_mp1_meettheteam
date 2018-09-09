//
//  GameScreenController-gamelogic.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit


extension GameScreenController {
    
    // New Question Control
    
    
    /// Generates a new question and updates the UI to reflect the new function
    @objc func new_question() {
        curr_round = RoundGenerator()
        
        promptImage.image = curr_round.promptImage
        reset_button_values_and_format()
        
        accepting_input = true
        time_left_in_round = 5
        
        start_timer()
    }
    
    
    /// Resets the button values and returns their format to the original state
    func reset_button_values_and_format() {
        for i in 0..<4 {
            optionButtons[i].setTitle(curr_round.list_of_names[i], for: .normal)
            optionButtons[i].setTitleColor(StyleColors.BLUE, for: .normal)
        }
    }
    
    /// Starts the 5-second countdown until failure
    func start_timer() {
        gameTimer = Timer.scheduledTimer(timeInterval: TIMER_PRECISION, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    /// Updates the timer's value and the displayed time left. Triggers the time's up failure
    @objc func updateClock() {
        time_left_in_round -= TIMER_PRECISION
        if time_left_in_round > 0 {
            countDown.text = "\(Int(time_left_in_round)+1)"
        } else {
            time_expired()
        }
    }
    
    /* When times up, this function peforms the following actions:
        • ends the round,
        • breaks the streak
        • reveals the answer
        • pushes the round to the statistics object
        • starts a timer for the next question.
    */
    func time_expired() {
        accepting_input = false
        gameTimer.invalidate()
        show_answer(harsh: true)
        failed()
        prepare_for_next_question(attempt: "[Time Expired].")
    }
    

    
    /* Processes input from the option buttons if the game is in an accepting state.
        • ends the round
        • checks the input's correctness
        • reveals the answer
        • pushes the round to the statistics object
        • starts a timer for the next question.
    */
    /// - Parameter sender: The Button that triggered this event. Used to represent user's selected value
    @objc func process_answer(sender: UIButton){
        if !accepting_input {
            return
        }
        gameTimer.invalidate()
        accepting_input = false
        if sender.tag != curr_round.indexOfCorrect {
            show_answer(single_wrong: sender)
            failed()
        } else {
            show_answer()
            success()
            updateScore()
        }
        
        prepare_for_next_question(attempt: (sender.titleLabel?.text)!)
    
    }
    
    /// Informs the user of their failure and kills the streak
    func failed() {
        countDown.text = get_sad_emoji()
        stats.streak_active = false
        stats.streak = 0
    }
    
    
    /// Informs the user of their success, handles score and score_streak handling accordingly
    func success() {
        countDown.text = get_happy_emoji()
        stats.score = stats.score + 1
        stats.streak_active = true
        stats.streak = stats.streak + 1
        if stats.streak > stats.best_streak {
            stats.best_streak = stats.streak
        }
        
    }
    
    /// Reveals the correct answer
    ///
    /// - Parameters:
    ///   - harsh: if True, displays all the wrong answer
    ///   - single_wrong: if not nil, marks this UIButton as the wrong selection
    func show_answer(harsh: Bool = false, single_wrong: UIButton? = nil) {
        optionButtons[curr_round.indexOfCorrect].setTitleColor(StyleColors.GREEN, for: .normal)
        if harsh {
            for i in 0..<4 {
                if i != curr_round.indexOfCorrect {
                    optionButtons[i].setTitleColor(StyleColors.RED, for: .normal)
                }
            }
        } else if single_wrong != nil {
            single_wrong?.setTitleColor(StyleColors.RED, for: .normal)
        }
    }
    
    
    /// Takes the current round information and pushes it to the stats object. Initializes a timer that lets the user view the result of their input
    ///
    /// - Parameter attempt: The guess that the user had
    func prepare_for_next_question(attempt: String){
        stats.last3.enqueue(StatsTracker.RoundResult(img: promptImage.image!, guess: attempt, answer: curr_round.correctName))
        
        next_round_timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(new_question), userInfo: nil, repeats: false)
    }
    
    
    /* When called, resumes the game with the following actions:
        • Enables input
        • Loads a new question
        • Changes the pause button state
        • Hide the new game button.
     */
    func resume_game() {
        stopButton.setTitle("Pause", for: .normal)
        gameTimer.invalidate()
        accepting_input = false
        curr_state = GAME_STATE.RUNNING
        new_question()
        show_hide_new(true)
    }
    
    /* When called, resumes the game with the following actions:
        • Invalidates both timers
        • Invalidates future input
        • Hides the question so users can't cheat
        • Resets the clock
        • Enables ability to start a new game
    */
    func pause_game() {
        stopButton.setTitle("Resume", for: .normal)
        gameTimer.invalidate()
        next_round_timer?.invalidate()
        accepting_input = false
        
        reset_button_values_and_format()
        mask_data()
        
        time_left_in_round = 5
        updateClock()
        curr_state = GAME_STATE.STOPPED
        show_hide_new(false)
        
    }
    
    
    /// Replaces the prompt image with an anonymous avatar and hides the button text
    func mask_data() {
        promptImage.image = UIImage(named: "questionman_white")
        for i in 0..<4 {
            optionButtons[i].setTitle("", for: .normal)
        }
    }
    

    /// Shows or hides the New Game button, animates it in/out
    ///
    /// - Parameter hideNewGame: indicates if the object is to hide the new game button.
    func show_hide_new(_ hideNewGame: Bool) {
        if hideNewGame {
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.newGame.transform = CGAffineTransform(translationX: 0, y: 0)
                self.stopButton.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.newGame.transform = CGAffineTransform(translationX: 125, y: 0)
                self.stopButton.transform = CGAffineTransform(translationX: -125, y: 0)
            })
        }
    }
    
    
    // Generic Helper Functions
    
    
    /// Gets a sad emoji for the feedback.
    ///
    /// - Returns: String Emoji with a negative connection
    func get_sad_emoji() -> String {
        return SAD_EMOJIS[Int(arc4random_uniform(UInt32(SAD_EMOJIS.count)))]
    }
    
    /// Gets a happy emoji for the feedback.
    ///
    /// - Returns: String Emoji with a positive connection
    func get_happy_emoji() -> String {
        return HAPPY_EMOJIS[Int(arc4random_uniform(UInt32(HAPPY_EMOJIS.count)))]
    }
    /// Updates the score to display the value shown.
    func updateScore(){
        scoreValue.text = "\(stats.score)"
    }
    

}

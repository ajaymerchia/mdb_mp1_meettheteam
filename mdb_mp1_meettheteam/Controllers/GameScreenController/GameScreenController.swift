//
//  GameScreenController.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

class GameScreenController: UIViewController {

    enum GAME_STATE {
        case RUNNING
        case STOPPED
    }
    
    // Game State/Exit Buttons
    var linkToStats: UIButton!
    
    var preload_value: Int!
    
    var stopButton: UIButton!
    var newGame: UIButton!
    
    var curr_state = GAME_STATE.RUNNING
    
    
    // Game Timers
    var countDown: UILabel!
    
    var gameTimer: Timer!
    var next_round_timer:Timer!
    let TIMER_PRECISION = 0.01
    
    var time_left_in_round: Double = 5.0
    
    
    // Score Trackers
    var scoreLabel: UILabel!
    var scoreValue: UILabel!
    
    var stats: StatsTracker.STATS!
    
    // Game GUI/Data Handling
    // Prompt
    var imageFrame: UIImageView!
    var promptImage: UIImageView!
    var promptText: UILabel!
    
    // Option Selecting
    var optionButtons : [UIButton] = []
    var accepting_input:Bool = true
    
    // Data
    var curr_round: RoundGenerator!
    
    let SAD_EMOJIS = ["💥","😢","🤯","❌", "💩"]
    let HAPPY_EMOJIS = ["😀","👏","⭐️","❤️","✅"]
    
    
    
    /// Load the Background Image, UI Components, Link Buttons, and Start Game
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Image
        Defaults.addBackgroundImage(given_view: self.view)
        
        // Initialize UI Components
        init_buttons()
        init_text()
        init_images()
        
        // Establish Button Behavior
        for button in optionButtons {
            button.addTarget(self, action: #selector(process_answer), for: .touchUpInside)
        }
        
        stopButton.addTarget(self, action: #selector(state_button_handler), for: .touchUpInside)
        newGame.addTarget(self, action: #selector(resetScore_sendHome), for: .touchUpInside)
        linkToStats.addTarget(self, action: #selector(transfer_to_stats), for: .touchUpInside)
        
        //Initialize Game Values
        stats = StatsTracker.STATS()
        stats.best_streak = preload_value
        
        //Start the game if it isn't in pause mode
        if curr_state == GAME_STATE.RUNNING {
            new_question()
        }
    }
    
    
    /// Pause the game on screen exit
    ///
    /// - Parameter animated: Controls the animation of the view change
    override func viewWillDisappear(_ animated: Bool) {
        pause_game()
    }
    
    
    /// Passes the statistics object to the StatsViewController
    ///
    /// - Parameters:
    ///   - segue: segue being followed for this function call
    ///   - sender: Source of the Segue's trigger
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let statsVC = segue.destination as! StatsViewController
        statsVC.statistics = stats
    }

    
    /// Adds the StatsViewController to the current Navigation Controller
    @objc func transfer_to_stats(){
        performSegue(withIdentifier: "toStats", sender: self)
    }
    
    
    /// Pauses or Resumes the game based on the current state
    @objc func state_button_handler() {
        if curr_state == .STOPPED {
            resume_game()
        } else {
            pause_game()
        }
    }
    
    
    /// Handles 'new game' functionality to reset the score without resetting the best streak
    @objc func resetScore_sendHome() {
        let parent = self.navigationController?.viewControllers[0] as! StartScreenController
        parent.best_stored_score = stats.best_streak
        self.navigationController?.popViewController(animated: true)
    }
}

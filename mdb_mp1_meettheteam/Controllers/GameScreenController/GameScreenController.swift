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
    
    
    
    var linkToStats: UIButton!
    
    var countDown: UILabel!
    var scoreLabel: UILabel!
    var scoreValue: UILabel!
    
    var stats = StatsTracker.STATS()
    
    var promptImage: UIImageView!
    var promptText: UILabel!
    
    var stopButton: UIButton!
    var optionButtons : [UIButton] = []
    
    var curr_state = GAME_STATE.RUNNING
    var accepting_input:Bool = true
    var gameTimer: Timer!
    var time_left_in_round: Double = 5.0
    let TIMER_PRECISION = 0.01
    
    var curr_round: RoundGenerator!
    
    let SAD_EMOJIS = ["💥","😢","🤯","❌"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialize UI Components & Connect Segues
        init_buttons()
        init_text()
        init_images()
        linkToStats.addTarget(self, action: #selector(transfer_to_stats), for: .touchUpInside)
        
        //Establish Button Behavior
        for button in optionButtons {
            button.addTarget(self, action: #selector(process_answer), for: .touchUpInside)
        }
        
        stopButton.addTarget(self, action: #selector(state_button_handler), for: .touchUpInside)
        
        //Start the game if it isn't in pause mode
        if curr_state == GAME_STATE.RUNNING {
            new_question()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        pause_game()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! StatsViewController
        resultVC.statistics = stats
    }

    @objc func transfer_to_stats(){
        performSegue(withIdentifier: "toStats", sender: self)
    }
    
    @objc func state_button_handler() {
        if curr_state == .STOPPED {
            resume_game()
        } else {
            pause_game()
        }
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

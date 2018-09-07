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
    var score: Int!
    
    var promptImage: UIImageView!
    var promptText: UILabel!
    
    var stopButton: UIButton!
    var optionButtons : [UIButton] = []
    
    var curr_state = GAME_STATE.RUNNING
    var curr_round: RoundGenerator!
    
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
        
        //Start the game if it isn't in pause mode
        if curr_state == GAME_STATE.RUNNING {
            new_question()
            start_timer()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func transfer_to_stats(){
        performSegue(withIdentifier: "toStats", sender: self)
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

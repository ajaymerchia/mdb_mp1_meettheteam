//
//  GameScreenController-gamelogic.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit


extension GameScreenController {
    func new_question() {
        curr_round = RoundGenerator()
        promptImage.image = curr_round.promptImage
        
        for i in 0..<4 {
            optionButtons[i].setTitle(curr_round.list_of_names[i], for: .normal)
        }
    }
    
    func start_timer(){
        
    }
    
    @objc func process_answer(sender: UIButton){
        optionButtons[curr_round.indexOfCorrect].backgroundColor = StyleColors.GREEN
        if sender.tag != curr_round.indexOfCorrect {
            optionButtons[sender.tag].backgroundColor = StyleColors.RED
        } else {
            score++
            updateScore()
        }
    }
}

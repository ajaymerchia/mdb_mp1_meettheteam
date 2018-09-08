//
//  GameScreenController-initUI.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

extension GameScreenController {
    
    func init_images(){
        //Initialize the main image
        promptImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/2))
        promptImage.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3)
        promptImage.image = UIImage(named: "questionman_blue")
        promptImage.contentMode = .scaleAspectFit
        view.addSubview(promptImage)
        
    }
    
    func init_text(){
        //Initialize the Help Text (Instructions on what to do)
        promptText = UILabel(frame: CGRect(x: 0, y: view.frame.height*9/20, width: view.frame.width, height: 100))
        promptText.text = "Who is this?"
        promptText.textAlignment = .center
        view.addSubview(promptText)
        
        //Show the score in the top right
        scoreLabel = UILabel(frame: CGRect(x: view.frame.width-80, y: 40, width: 80, height: 20))
        scoreLabel.text = "Score:"
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        scoreValue = UILabel(frame: CGRect(x: view.frame.width-80, y: 60, width: 80, height: 20))
        scoreValue.text = "0"
        scoreValue.textAlignment = .center
        view.addSubview(scoreValue)
        
        countDown  = UILabel(frame: CGRect(x: 0, y: 70, width: view.frame.width, height: 50))
        countDown.text = "5"
        countDown.textAlignment = .center
        countDown.font = UIFont(name: "Arial", size: 60)
        view.addSubview(countDown)
    }
    
    func init_buttons(){
        
        linkToStats = UIButton(frame: CGRect(x: 20, y: 40, width: 40, height: 40))
        linkToStats.setImage(UIImage(named: "bar-chart"), for: UIControlState.normal)
        view.addSubview(linkToStats)
        
        
        stopButton = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height - 80, width: view.frame.width / 2, height: 50))
        stopButton.setTitle("Pause", for: .normal)
        stopButton.backgroundColor = .blue
        stopButton.layer.cornerRadius = 20
        view.addSubview(stopButton)
        
        
        let BUTTON_WIDTH:Int = Int(view.frame.width)*4/10
        let BUTTON_HEIGHT:Int = 50
        
        for i in 0..<4 {
            let r:Int = (i/2)
            let c:Int = i%2
            
            //Reserve 1/3 of horizontal space for margins, gutter = .5/10, button = 4/10, divider = 1/10, button = 4/10, gutter=.5/10
            let x_frac:Double = 0.5/10 + Double(c) * 0.5
            
            let x_co:Int = Int(x_frac * Double(view.frame.width))
            let y_co:Int = Int(view.frame.height) - 100*(3-r)
            optionButtons.append(UIButton(frame: CGRect(x: x_co, y: y_co, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)))
            optionButtons[i].setTitle("Button_\(i)", for: .normal)
            optionButtons[i].backgroundColor = .blue
            optionButtons[i].layer.cornerRadius = 20
            optionButtons[i].tag = i
            view.addSubview(optionButtons[i])
        }
    }
    
}

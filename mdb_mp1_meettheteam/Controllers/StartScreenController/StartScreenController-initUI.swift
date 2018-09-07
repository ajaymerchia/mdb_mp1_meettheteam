//
//  StartScreenController-initUI.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

extension StartScreenController {
    func init_text(){
        app_title = UILabel(frame: CGRect(x: 0, y: view.frame.height*1/2, width: view.frame.width, height: 100))
        app_title.text = "Who's Who?"
        app_title.textAlignment = .center
        view.addSubview(app_title)
    }
    
    func init_images(){
        logo_image_view = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height/4))
        
        
        let LOGO_WIDTH: CGFloat = 456
        let PHONE_WIDTH: CGFloat = 357
        let CENTER_BIAS = (LOGO_WIDTH-PHONE_WIDTH)/(2*LOGO_WIDTH)
        
    
        logo_image_view.center = CGPoint(x: view.frame.width/(2-CENTER_BIAS), y: view.frame.height/3)
        logo_image_view.image = UIImage(named: "mdb_logo")
        logo_image_view.contentMode = .scaleAspectFit
        view.addSubview(logo_image_view)
        
        
        
        
    }
    
    func init_buttons(){
        startButton = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height - 80, width: view.frame.width / 2, height: 50))
        startButton.setTitle("Start!", for: .normal)
        startButton.backgroundColor = .blue
        startButton.layer.cornerRadius = 20
        view.addSubview(startButton)
    }
}

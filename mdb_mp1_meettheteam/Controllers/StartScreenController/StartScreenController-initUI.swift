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
        app_title = UILabel(frame: CGRect(x: 0, y: view.frame.height*0.6, width: view.frame.width, height: 150))
        app_title.text = "Meet The Members"
        app_title.font = UIFont(name: "NaughtySquirrelShadowedDemo", size: 60)
        app_title.lineBreakMode = NSLineBreakMode.byWordWrapping
        app_title.numberOfLines = 2
        app_title.textColor = .white
        app_title.textAlignment = .center
        view.addSubview(app_title)

    }
    
    func init_images(){
        logo_image_view = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: view.frame.height/5))
        
        
        let LOGO_WIDTH: CGFloat = 480
        let PHONE_WIDTH: CGFloat = 350
        let CENTER_BIAS = (LOGO_WIDTH-PHONE_WIDTH)/(2*LOGO_WIDTH)
        
        
        logo_image_view.center = CGPoint(x: view.frame.width/(2-CENTER_BIAS), y: view.frame.height/2.5)
        logo_image_view.image = UIImage(named: "mdb_logo_white")
        logo_image_view.contentMode = .scaleAspectFill
        view.addSubview(logo_image_view)
        
        
        
        
    }
    
    func init_buttons(){
        startButton = UIButton(frame: CGRect(x: view.frame.width/4, y: view.frame.height - 110, width: view.frame.width / 2, height: 50))
        startButton.setTitle("Get Started!", for: .normal)
        
        startButton.backgroundColor = .white
        startButton.titleLabel?.font = UIFont(name: "Gentona-Bold", size: 30)
        startButton.setTitleColor(StyleColors.BLUE, for: .normal)
        startButton.layer.cornerRadius = 10
        view.addSubview(startButton)
        

    }
}

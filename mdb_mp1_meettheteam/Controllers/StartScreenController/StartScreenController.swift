//
//  ViewController.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import UIKit

class StartScreenController: UIViewController {

    var logo_image_view: UIImageView!
    var logo_image_view2: UIImageView!
    
    var app_title: UILabel!
    
    var startButton: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        init_images()
        init_text()
        init_buttons()
//        view.backgroundColor = UIColor.cyan
        startButton.addTarget(self, action: #selector(transfer_to_gamecontroller), for: .touchUpInside)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func transfer_to_gamecontroller() {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    


}


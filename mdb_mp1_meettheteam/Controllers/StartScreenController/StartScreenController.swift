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
    var app_title2: UILabel!
    
    var startButton: UIButton!
    
    var best_stored_score: Int = 0
    
    
    
    
    /// Hide Navigation Controller to allow for more aesthetic UI components
    ///
    /// - Parameter animated: determines whether or not the viewappearance should be animated (not used)
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    /// Adds background image, foreground images, text, buttons, and links buttons
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds background image
        Defaults.addBackgroundImage(given_view: self.view)

        // Do any additional setup after loading the view, typically from a nib.
        init_images()
        init_text()
        init_buttons()
        
        // Link Start Button to push a new Game Controller to the NavController
        startButton.addTarget(self, action: #selector(transfer_to_gamecontroller), for: .touchUpInside)

        

    }

    // Adds the GameScreen Controller to the Navigation Controller
    @objc func transfer_to_gamecontroller() {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    // Informs the new GameScreenController of a stats score to preload.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as! GameScreenController
        gameVC.preload_value = best_stored_score
    }
    


}


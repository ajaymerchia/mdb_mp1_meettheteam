//
//  StatsTracker.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit

class StatsTracker{
    struct RoundResult {
        var img: UIImage
        var guess: String
        var answer: String
    }
    
    struct STATS {
        var score: Int = 0
        var streak: Int = 0
        var streak_active:Bool = true
        var last3 = SizedQueue<RoundResult>(size: 3)
    }
}


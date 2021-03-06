//
//  RoundGenerator.swift
//  mdb_mp1_meettheteam
//
//  Created by Ajay Raj Merchia on 9/7/18.
//  Copyright © 2018 Ajay Raj Merchia. All rights reserved.
//

import Foundation
import UIKit


/// Generates the random values used in a round.
class RoundGenerator{
    var promptImage: UIImage
    var correctName: String
    var indexOfCorrect: Int
    var list_of_names: [String] = []
        
    static func getIndexOfName(_ name: String) -> Int {
        return Constants.names.index(of: name)!
    }
    
    
    /// Initializes instances variables including the prompt image, the options, and the correct answer
    init(){
        var random_options_selected = Set<Int>()
        let SIZE_OF_MDB = UInt32(Constants.names.count)
     
        while random_options_selected.count < 4 {
            let random_index = Int(arc4random_uniform(SIZE_OF_MDB))
            random_options_selected.insert(random_index)
        }
        
        indexOfCorrect = Int(arc4random_uniform(4))
        let options_as_array = Array(random_options_selected)
        
        correctName = Constants.names[options_as_array[indexOfCorrect]]
        promptImage = Constants.getImageFor(name: correctName)
        
        for i in options_as_array {
            list_of_names.append(Constants.names[i])
        }
    
        
        
        
        
    }
}

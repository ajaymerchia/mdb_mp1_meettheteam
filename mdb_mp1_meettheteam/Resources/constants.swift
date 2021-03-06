//
//  MDB Mini Project 1 - Match the Members!
//
//  Constants.swift
//  Created by Will Oakley on 9/5/18.
//

import Foundation
import UIKit

// An extension of UIFont that enables bold-italic attribute addition
// src: https://stackoverflow.com/questions/4713236/how-do-i-set-bold-and-italic-on-uilabel-of-iphone-ipad
extension UIFont {
    var bold: UIFont {
        return with(traits: .traitBold)
    } // bold
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    } // italic
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    } // boldItalic
    
    
    func with(traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    } // with(traits:)
} // extension

/// μΔΒ club member names and access patterns
class Constants {
    static let names = ["Aayush Tyagi", "Abhinav Koppu", "Aditya Yadav", "Ajay Merchia", "Alice Zhao", "Amy Shen", "Anand Chandra", "Andres Medrano", "Angela Dong", "Anika Bagga", "Anmol Parande", "Austin Davis", "Ayush Kumar", "Brandon David", "Candice Ye", "Carol Wang", "Cody Hsieh", "Daniel Andrews", "Daniel Jing", "Eric Kong", "Ethan Wong", "Fang Shuo", "Izzie Lau", "Jaiveer Singh", "Japjot Singh", "Jeffrey Zhang", "Joey Hejna", "Julie Deng", "Justin Kim", "Kaden Dippe", "Kanyes Thaker", "Kayli Jiang", "Kiana Go", "Leon Kwak", "Levi Walsh", "Louie Mcconnell", "Max Miranda", "Michelle Mao", "Mohit Katyal", "Mudabbir Khan", "Natasha Wong", "Nikhar Arora", "Noah Pepper", "Radhika Dhomse", "Sai Yandapalli", "Saman Virai", "Sarah Tang", "Sharie Wang", "Shiv Kushwah", "Shomil Jain", "Shreya Reddy", "Shubha Jagannatha", "Shubham Gupta", "Srujay Korlakunta", "Stephen Jayakar", "Suyash Gupta", "Tiger Chen", "Vaibhav Gattani", "Victor Sun", "Vidya Ravikumar", "Vineeth Yeevani", "Wilbur Shi", "William Lu", "Will Oakley", "Xin Yi Chen", "Young Lin" ]
    
    
    /// Returns a UIImage associated with the name given
    ///
    /// - Parameter name: name for which to select an image
    /// - Returns: image associated with the name
    static func getImageFor(name: String) -> UIImage {
        let noWhitespace = name.components(separatedBy: .whitespaces).joined().lowercased()
        return UIImage(named: noWhitespace)!
    }
}



class Defaults {
    
    
    /// Adds the question mark based background image to the given view
    ///
    /// - Parameter given_view: View to which a background image should be added
    static func addBackgroundImage(given_view: UIView) {
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: given_view.frame.width, height: given_view.frame.height))
        backgroundImage.image = UIImage(named: "randomqs.jpg")
        given_view.insertSubview(backgroundImage, at: 0)
    }
}


/// A Simple class to assist with UI Color theme
class StyleColors {
    static let LIGHT_RED = rgba(255,168,168,1)
    static let LIGHT_GREEN = rgba(168,255,168,1)
    
    
    static let RED = rgba(239,47,47,1)
    static let GREEN = rgba(48,191,28,1)
    static let BLUE = rgba(89,187,247,1)

    
    /// Easy UI Color creation method
    ///
    /// - Parameters:
    ///   - r: red on a scale from 0 to 255
    ///   - g: green on a scale from 0 to 255
    ///   - b: blue on a scale from 0 to 255
    ///   - a: alpha coeffiecient from 0 to 1
    /// - Returns: UIColor with the given rgba attributes
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let max_val = CGFloat(255.00)
        return UIColor(red: r/max_val, green: g/max_val, blue: b/max_val, alpha: a)
    }
}


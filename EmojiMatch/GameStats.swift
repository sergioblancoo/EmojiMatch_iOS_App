//
//  GameStats.swift
//  EmojiMatch
//
//  Created by Sergio Blanco on 13/2/18.
//  Copyright © 2018 Sergio Blanco. All rights reserved.
//

import Foundation

struct currentGame {
    var wordRandomize: [String]
    var imageTouched: String
    var matched: Bool

    
    mutating func matching(imageTouched: String, wordDisplayed: [String]){
        if imageTouched == wordDisplayed[0]{
            matched = true
        }
        else{
            matched = false
        }
    }
}

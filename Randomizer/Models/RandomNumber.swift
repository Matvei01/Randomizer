//
//  RandomNumber.swift
//  Randomizer
//
//  Created by Matvei Khlestov on 29.07.2023.
//

import Foundation

struct RandomNumber {
    var minimumValue: Int
    var maximumValue: Int
    
    var getRandom: Int {
        Int.random(in: minimumValue...maximumValue)
    }
}

//
//  RandomNumber.swift
//  Randomizer
//
//  Created by Matvei Khlestov on 28.05.2022.
//

import Foundation

struct RandomNumber {
    var minimumValue: Int
    var maximumValue: Int
    
    var getRandom: Int {
        Int.random(in: minimumValue...maximumValue)
    }
}

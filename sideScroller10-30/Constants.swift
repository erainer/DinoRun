//
//  Constants.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import Foundation
import UIKit

//Physics categories
struct PhysicsCategory{
    static let none : UInt32 = 0
    static let all: UInt32 = UInt32(UInt.max)
    static let playerCategory: UInt32 = 0b1
    static let rockCategory: UInt32 = 0b10
}

//Player Start Position Y
let playerStartY: CGFloat = 275

//Rock Start Position Y
let rockYPos = 200

//Used for random spawn location on the X axis
let minObjectX: UInt32 = 1900
let maxObjectX: UInt32 = 4000

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
let playerCategory: UInt32 = 0x1 << 0
let rockCategory: UInt32 = 0x1 << 1

//Player Start Position Y
let playerStartY: CGFloat = 275

//Rock Start Position Y
let rockYPos = 200

//Used for random spawn location on the X axis
let minObjectX: UInt32 = 1900
let maxObjectX: UInt32 = 4000

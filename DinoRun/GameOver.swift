//
//  Score.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit

class GameOver: UIViewController{

    
   
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var name2: UILabel!
    
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var name3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "scores", ofType: "plist")
        
        let items = NSArray(contentsOf: URL.init(fileURLWithPath: path!)) as! [String]
        name1.text = items[0]
        score1.text = items[1]
        name2.text = items[2]
        score2.text = items[3]
        name3.text = items[4]
    }
}





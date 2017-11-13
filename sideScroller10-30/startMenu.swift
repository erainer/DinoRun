//
//  ViewController.swift
//  sideScroller10-30
//
//  Created by Emily on 11/8/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit

class startMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        supportedInterfaceOrientations()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.landscape.rawValue)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

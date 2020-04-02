//
//  Layout3View.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 01/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class Layout3View: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var imageUpLeft: UIImageView!
    @IBOutlet weak var imageUpRight: UIImageView!
    @IBOutlet weak var imageDownLeft: UIImageView!
    @IBOutlet weak var imageDownRight: UIImageView!
    
    
    @IBAction func clickOnButtonUpLeft(_ sender: Any) {
    }
    
    @IBAction func clickOnButtonUpRight(_ sender: Any) {
    }
    
    @IBAction func clickOnButtonDownLeft(_ sender: Any) {
    }

    
    @IBAction func clickOnButtonDownRight(_ sender: Any) {
    }

}

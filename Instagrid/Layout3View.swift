//
//  Layout3View.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 01/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class Layout3View: UIView {
    var delegate:ViewDelegate?
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped1(sender: sender)
    }
    
    @IBAction func button2Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped2(sender: sender)
    }
    
    @IBAction func button3Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped3(sender: sender)
    }
    @IBAction func button4Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped4(sender: sender)
       }
}

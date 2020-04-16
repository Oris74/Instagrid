//
//  Layout1View.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 01/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class Layout1View: UIView, LayoutDelegate {
    weak var delegate:ViewDelegate?
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
   
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped1(sender: sender)
        self.viewControllerParent?.layoutDelegate = self
       }
    @IBAction func button2Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped2(sender: sender)
        self.viewControllerParent?.layoutDelegate = self
    }
    @IBAction func button3Tapped(_ sender: UIButton) {
        delegate!.didButtonTapped3(sender: sender)
        self.viewControllerParent?.layoutDelegate = self
    }
    
    var viewControllerParent:ViewController?
    
   /* override func didMoveToSuperview() {
       super.didMoveToSuperview()
       self.viewControllerParent?.layoutDelegate = self
       print("1->\(self)")
    }*/
    
   func displayImage(_ image: UIImage, at buttons: Int)
    {
        switch buttons {
        case 1:
            self.image1.contentMode = .scaleAspectFill
            self.image1.image = image
        case 2:
            self.image2.contentMode = .scaleAspectFill
            self.image2.image = image
        case 3:
            self.image3.contentMode = .scaleAspectFill
            self.image3.image = image
        default: break
        }
    }
    
}

protocol ViewDelegate:AnyObject {
    func didButtonTapped1(sender: UIButton)
    func didButtonTapped2(sender: UIButton)
    func didButtonTapped3(sender: UIButton)
    func didButtonTapped4(sender: UIButton)
}

protocol LayoutDelegate:AnyObject {
    func displayImage(_ image: UIImage, at buttons: Int)
}


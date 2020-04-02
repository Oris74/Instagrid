//
//  ViewController.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 16/03/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     
   @IBOutlet weak var displayPattern: UIView!
    
   @IBOutlet weak var buttonPortraitLeft: UIButton!
   @IBOutlet weak var buttonPortraitRight: UIButton!
   @IBOutlet weak var buttonPortraitCentral: UIButton!
    
    
   @IBOutlet weak var buttonLandscapeUp: UIButton!
   @IBOutlet weak var buttonLandscapeMiddle: UIButton!
   @IBOutlet weak var buttonLandscapeDown: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func didTouchButtonPortraitLeft(_ sender: Any) {
        buttonPortraitLeft.setImage(UIImage(named:"Selected.png"), for: .normal)
        buttonPortraitCentral.setImage(nil, for: .normal)
        buttonPortraitRight.setImage(nil, for: .normal)
        
    }
    
    @IBAction func didTouchButtonPortraitCentral(_ sender: Any) {
        buttonPortraitLeft.setImage(nil, for: .normal)
        buttonPortraitCentral.setImage(UIImage(named: "Selected.png"), for: .normal)
        buttonPortraitRight.setImage(nil, for: .normal)
        
    }
    
    @IBAction func didTouchButtonPortraitRight(_ sender: Any) {
        buttonPortraitLeft.setImage(nil, for: .normal)
        buttonPortraitCentral.setImage(nil, for: .normal)
        buttonPortraitRight.setImage(UIImage(named:"Selected.png"), for: .normal)
        
    }
    
    @IBAction func didTouchButtonLandscapeUp(_ sender: Any) {
        buttonLandscapeUp.setImage(UIImage(named:"Selected.png"), for: .normal)
        buttonLandscapeMiddle.setImage(nil, for: .normal)
        buttonLandscapeDown.setImage(nil, for: .normal)
        
    }
    @IBAction func didTouchButtonLandscapeMiddle(_ sender: Any) {
        buttonLandscapeUp.setImage(nil, for: .normal)
        buttonLandscapeMiddle.setImage(UIImage(named:"Selected.png"), for: .normal)
        buttonLandscapeDown.setImage(nil, for: .normal)
        
    }
    @IBAction func didTouchButtonLandscapeDown(_ sender: Any) {
        buttonLandscapeUp.setImage(nil, for: .normal)
        buttonLandscapeMiddle.setImage(nil, for: .normal)
        buttonLandscapeDown.setImage(UIImage(named:"Selected.png"), for: .normal)
        
    }
    
    

    
}


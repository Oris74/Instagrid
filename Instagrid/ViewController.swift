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
    
    @IBOutlet var buttonsPortrait: [UIButton]!
    @IBOutlet var buttonsLandscape: [UIButton]!
    @IBAction func buttonsPortraitTapped(_ sender: UIButton) {
        updateButton(buttonTapped: sender.tag)
        updatePattern(pattern: ViewController.Pattern(rawValue: sender.tag)!)
    }
    
    @IBAction func buttonsLandscapeTapped(_ sender: UIButton) {
        updateButton(buttonTapped: sender.tag)
        updatePattern(pattern: ViewController.Pattern(rawValue: sender.tag)!)
    }
    
    private enum Pattern: Int {
        case pattern1,pattern2,pattern3
    }
    
    private enum Orientation:String {
        case portrait,landscape
    }
        
    private var deviceOrientation:Orientation = .portrait
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updatePattern(pattern: .pattern3)
    }

   
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
            
            if windowInterfaceOrientation.isLandscape {
                self.deviceOrientation = .landscape
            } else {
                self.deviceOrientation = .portrait
            }
        })
    }
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    
    private func  updatePattern(pattern: Pattern) {
        switch pattern {
        case .pattern1:
            if let currentPattern = Bundle.main.loadNibNamed("Layout1View", owner: displayPattern, options: nil)?.first as?Layout1View {
                displayPattern.addSubview(currentPattern)
                // currentPattern.centerXAnchor.constraint(equalTo: displayPattern.centerXAnchor).isActive = true
                //  currentPattern.centerYAnchor.constraint(equalTo: displayPattern.centerYAnchor).isActive = true
              }
        case .pattern2:
            if let currentPattern = Bundle.main.loadNibNamed("Layout2View", owner: displayPattern, options: nil)?.first as?Layout2View {
                displayPattern.addSubview(currentPattern)
            }
        case .pattern3:
            if let currentPattern = Bundle.main.loadNibNamed("Layout3View", owner: displayPattern, options: nil)?.first as?Layout3View {
                displayPattern.addSubview(currentPattern)
            }
        }
    }
    
    
    private func updateButton (buttonTapped: Int ) {
        switch deviceOrientation {
        case .portrait:
            for button in 0...2 {
                       if button == buttonTapped {
                        buttonsPortrait[button].setImage(
                            UIImage(named:"Selected.png"), for: .normal)
                       } else {
                        buttonsPortrait[button].setImage(nil, for: .normal)
                       }
                   }
        case .landscape:
            for button in 0...2 {
                if button == buttonTapped {
                    buttonsLandscape[button].setImage(
                        UIImage(named:"Selected.png"), for: .normal)
                } else {
                    buttonsLandscape[button].setImage(nil, for: .normal)
                }
            }
        }
    }
}


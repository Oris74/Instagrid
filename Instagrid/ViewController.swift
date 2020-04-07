//
//  ViewController.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 16/03/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var displayPattern: UIView!
    
    @IBOutlet var buttonsPortrait: [UIButton]!
    @IBOutlet var buttonsLandscape: [UIButton]!
    @IBAction func buttonsPortraitTapped(_ sender: UIButton) {
        updateButton(buttonTapped: sender.tag)
        updatePattern(selectedPattern: ViewController.Pattern(rawValue: sender.tag)!)
    }
    
    @IBAction func buttonsLandscapeTapped(_ sender: UIButton) {
        updateButton(buttonTapped: sender.tag)
        updatePattern(selectedPattern: ViewController.Pattern(rawValue: sender.tag)!)
    }
    var imagePicker = UIImagePickerController()
    
    private enum Pattern: Int {
        case pattern1,pattern2,pattern3
        static let mapper: [Pattern: String] = [
            .pattern1: "Layout1View",
            .pattern2: "Layout2View",
            .pattern3: "Layout3View"
        ]
        var string: String {
            return Pattern.mapper[self]!
        }
    }
    
    private enum Orientation:String {
        case portrait,landscape
    }
        
    private var deviceOrientation:Orientation = .portrait
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updatePattern(selectedPattern: .pattern2)
        imagePicker.delegate = self
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
    
    
    private func  updatePattern(selectedPattern: Pattern) {
        let layoutView:UIView
        print("\(selectedPattern)\n \(selectedPattern.string)")
        switch selectedPattern {
        case .pattern1:
            guard let pattern = Bundle.main.loadNibNamed(
                selectedPattern.string, owner: displayPattern,
                options: nil)?.first as? Layout1View else { return }
            layoutView = pattern
        case .pattern2:
            guard let pattern = Bundle.main.loadNibNamed(
                selectedPattern.string, owner: displayPattern,
                options: nil)?.first as? Layout2View else { return }
              layoutView = pattern
        case .pattern3:
            guard let pattern = Bundle.main.loadNibNamed(
                selectedPattern.string, owner: displayPattern,
                options: nil)?.first as? Layout3View else { return }
              layoutView = pattern
        }
            
        displayPattern.addSubview(layoutView)
        addLayoutConstraint(parentView: displayPattern, childView: layoutView)
    }
    
    private func addLayoutConstraint(parentView: UIView, childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let leftSideConstraint = NSLayoutConstraint(item: parentView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: childView,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: -15.0
        )
        let bottomConstraint = NSLayoutConstraint(item: parentView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: childView,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 15.0
        )
        let rightConstraint = NSLayoutConstraint(item: parentView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: childView,
                                                 attribute: .right,
                                                 multiplier: 1.0,
                                                 constant: 15.0
        )
        let topConstraint = NSLayoutConstraint(item: parentView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: childView,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: -15.0
        )
        parentView.addConstraints([leftSideConstraint, bottomConstraint, rightConstraint, topConstraint])
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


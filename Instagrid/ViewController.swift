//
//  ViewController.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 16/03/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewDelegate, ImagePickerDelegate {
    func didSelectImage(image: UIImage?) {
        if  let layout = currentLayout as? Layout1View {
            switch didButtonTapped {
            case 1:
                layout.image1.contentMode = .scaleAspectFill
                layout.image1.image = image
            case 2:
                layout.image2.contentMode = .scaleAspectFill
                layout.image2.image = image
            case 3:
                layout.image3.contentMode = .scaleAspectFill
                layout.image3.image = image
            default: break
            }
        }
        if  let layout = currentLayout as? Layout2View {
                switch didButtonTapped {
                case 1:
                    layout.image1.contentMode = .scaleAspectFill
                    layout.image1.image = image
                case 2:
                    layout.image2.contentMode = .scaleAspectFill
                    layout.image2.image = image
                case 3:
                    layout.image3.contentMode = .scaleAspectFill
                    layout.image3.image = image
                default: break
                }
        }
        if  let layout = currentLayout as? Layout3View {
            switch didButtonTapped {
            case 1:
                layout.image1.contentMode = .scaleAspectFill
                layout.image1.image = image
            case 2:
                layout.image2.contentMode = .scaleAspectFill
                layout.image2.image = image
            case 3:
                layout.image3.contentMode = .scaleAspectFill
                layout.image3.image = image
            case 4:
                layout.image4.contentMode = .scaleAspectFill
                layout.image4.image = image
            default: break
            }
        }
     
    }
    
    func didButtonTapped1(sender: UIButton) {
        didButtonTapped = 1
        self.imagePicker.present(from: sender)
    }
    
    func didButtonTapped2(sender: UIButton) {
        didButtonTapped = 2
        self.imagePicker.present(from: sender)
    }

    func didButtonTapped3(sender: UIButton) {
        didButtonTapped = 3
        self.imagePicker.present(from: sender)
      }

    func didButtonTapped4(sender: UIButton) {
        didButtonTapped = 4
        self.imagePicker.present(from: sender)
      }
   
    @IBOutlet weak var displayPattern: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    @IBAction func buttonsTapped(_ sender: UIButton) {
        updatePattern(button: sender.tag)
    }
    
    var imagePicker: ImagePicker!
    var didButtonTapped:Int = 0
    private var layout1 =
        Bundle.main.loadNibNamed("Layout1View", owner: nil,  options: nil)?.first as! Layout1View
        
    private var layout2 =
        Bundle.main.loadNibNamed("Layout2View", owner: nil, options: nil)?.first as! Layout2View
    private var layout3 =
        Bundle.main.loadNibNamed("Layout3View", owner: nil, options: nil)?.first as! Layout3View
    
    var currentLayout:UIView?
    
    private enum Orientation:String {
        case portrait,landscape
    }
        
    private var deviceOrientation:Orientation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateOrientation()
        updatePattern(button: 2)
        
        layout1.delegate = self
        layout2.delegate = self
        layout3.delegate = self

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        upSwipe.direction = .up
        
        displayPattern.addGestureRecognizer(leftSwipe)
        displayPattern.addGestureRecognizer(upSwipe)

    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
      updateOrientation()
    }

    private func updateOrientation() {
        let height =  UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width

        if  height > width {
            deviceOrientation = .portrait
        } else {
            deviceOrientation = .landscape
        }
    }
    
    private func  updatePattern(button: Int) {
        updateButton(buttonTapped: button)
        switch button {
        case 0:
            currentLayout = layout1
        case 1:
            currentLayout = layout2
        case 2:
            currentLayout = layout3
        default: break
        }
        
        displayPattern.addSubview(currentLayout!)
        addLayoutConstraint(parentView: displayPattern, childView: currentLayout!)
    }

    private func updateButton (buttonTapped: Int ) {
        for button in 0...2 {
            if button == buttonTapped {
                buttons[button].setImage(
                    UIImage(named:"Selected.png"), for: .normal)
            } else {
                buttons[button].setImage(nil, for: .normal)
            }
        }
    }
    
    //*************************************************************
    //*** handleSwipes                                          ***
    //*** manage swipe gesture (up && left)                     ***
    //*************************************************************
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .up),
           (deviceOrientation == .portrait)  {
            
            let screenHeight = UIScreen.main.bounds.height
            var translationTransform:CGAffineTransform
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)     //move the view to the top
            
            UIView.animate(withDuration: 3, animations: {
                self.displayPattern.transform = translationTransform }, completion: { (true) in
                    let myPattern = self.captureImageFromDisplayPattern(self.displayPattern)
                    let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)
                    self.present(activityController, animated: true, completion:nil)            // bring up the controller

                    activityController.completionWithItemsHandler = {(type,completed,items,error) in
                    let translationTransform = CGAffineTransform(translationX: 0, y: 0)            // get back the view at the end
                    UIView.animate(withDuration: 3, animations: {
                        self.displayPattern.transform = translationTransform
                    }, completion: nil)
                    }
            })
        }
        if (sender.direction == .left),
            (deviceOrientation == .landscape) {
            let screenWidth = UIScreen.main.bounds.width
            var translationTransform:CGAffineTransform
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0) //move the view to the left

            UIView.animate(withDuration: 3, animations: {
                self.displayPattern.transform = translationTransform }, completion: { (true) in
                    let myPattern = self.captureImageFromDisplayPattern(self.displayPattern)
                    let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)           //bring uop the controller

                    activityController.completionWithItemsHandler = {(type,completed,items,error) in
                        let translationTransform = CGAffineTransform(translationX: 0, y: 0)     // get back the view at the end
                        UIView.animate(withDuration: 3, animations: {
                            self.displayPattern.transform = translationTransform
                        }, completion: nil)
                    }
            })
        }
      
    }
    //***************************************************************
    //*** captureImageFromDislayPattern                           ***
    //*** capture an image of the view in parameter               ***
    //*** view:  name of the view.  return : UIImage              ***
    //***************************************************************
    func captureImageFromDisplayPattern(_ view:UIView?) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
        let capturedImage = renderer.image {
            (ctx) in
            view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
        return capturedImage
    }

    //************************************************************************
    //*** addLayoutConstraint                                              ***
    //*** define constraints for layouts inside container displayPattern   ***
    //************************************************************************
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
}


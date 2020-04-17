//
//  ViewController.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 16/03/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewDelegate, ImagePickerDelegate {
   
    @IBOutlet weak var displayPattern: UIView!
    
    @IBOutlet var buttons: [UIButton]!
  
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
    
    var imagePicker:ImagePicker

    weak var layoutDelegate:LayoutDelegate?
    
    private var deviceOrientation:Orientation?
    
   /* override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.imagePicker = ImagePicker()
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        imagePicker.presentationController = self
        imagePicker.delegate = self
        layout1.delegate = self
        layout1.viewControllerParent = self
        layout2.delegate = self
        layout2.viewControllerParent = self
        layout3.delegate = self
        layout3.viewControllerParent = self
    }*/
    
    required init?(coder: NSCoder) {
        self.imagePicker = ImagePicker()
        super.init(coder:coder)
        
        imagePicker.presentationController = self
        imagePicker.delegate = self
        
        layout1.delegate = self
        layout1.viewControllerParent = self
        layout2.delegate = self
        layout2.viewControllerParent = self
        layout3.delegate = self
        layout3.viewControllerParent = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateOrientation()
        updatePattern(button: 1)

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        upSwipe.direction = .up
        
        displayPattern.addGestureRecognizer(leftSwipe)
        displayPattern.addGestureRecognizer(upSwipe)
    }

    @IBAction func buttonsTapped(_ sender: UIButton) {
          updatePattern(button: sender.tag)
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
    
    
    func didSelectImage(image: UIImage?) {
        guard let myImage = image else { return }
        layoutDelegate?.displayImage(myImage, at: didButtonTapped)
    }
       
    func didButtonTapped1(sender: UIButton) {
        didButtonTapped = 1
        imagePicker.present(from: sender)
    }
       
    func didButtonTapped2(sender: UIButton) {
        didButtonTapped = 2
        imagePicker.present(from: sender)
    }

    func didButtonTapped3(sender: UIButton) {
        didButtonTapped = 3
        imagePicker.present(from: sender)
    }

    func didButtonTapped4(sender: UIButton) {
        didButtonTapped = 4
        imagePicker.present(from: sender)
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
            
            animatePattern(transform: translationTransform)
 
        }
        if (sender.direction == .left),
            (deviceOrientation == .landscape) {
            let screenWidth = UIScreen.main.bounds.width
            var translationTransform:CGAffineTransform
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0) //move the view to the left
            animatePattern(transform: translationTransform)
        }
      
    }
    
    private func displayActivityViewController() -> UIActivityViewController {
        let myPattern = self.captureImageFromDisplayPattern(self.displayPattern)
        let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)     //bring uop the controller
        return activityController
    }
    
    private func animateBackToOrigin() {
        let translationTransform = CGAffineTransform(translationX: 0, y: 0)     // get back the view at the end
        UIView.animate(withDuration: 3, animations: {
            self.displayPattern.transform = translationTransform
        }, completion: nil)
    }
    
    private func animatePattern(transform: CGAffineTransform) {
    UIView.animate(withDuration: 3, animations: {
        self.displayPattern.transform = transform }, completion: { (true) in
            let activityController = self.displayActivityViewController()
            activityController.completionWithItemsHandler = {(type,completed,items,error) in
                self.animateBackToOrigin()
                }
            })
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


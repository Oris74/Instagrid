//
//  ViewController.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 16/03/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewDelegate, ImagePickerDelegate {
    ///central View that will include the selected pattern
    @IBOutlet weak var displayPattern: UIView!
    ///3 patterns buttons collection
    @IBOutlet private var patternButton: [UIButton]!
    ///current ImageBoutton tapped to display image
    private var didImageButtonTapped: Int = 0

    private var layout1: Layout1View?
    private var layout2: Layout2View?
    private var layout3: Layout3View?

    private var currentLayout: ManageLayout

    private enum Orientation: String {
        case portrait, landscape
    }

    private let imagePicker: ImagePicker

    private var deviceOrientation: Orientation?

    required init?(coder: NSCoder) {
        self.layout1 = Bundle.main.loadNibNamed(
            "Layout1View", owner: nil, options: nil)?.first as? Layout1View
        self.layout2 = Bundle.main.loadNibNamed(
            "Layout2View", owner: nil, options: nil)?.first as? Layout2View
        self.layout3 = Bundle.main.loadNibNamed(
            "Layout3View", owner: nil, options: nil)?.first as? Layout3View

        self.currentLayout = layout2!

        self.imagePicker = ImagePicker()
        super.init(coder: coder)

        imagePicker.delegate = self

        layout1?.delegate = self
        layout2?.delegate = self
        layout3?.delegate = self

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

    @IBAction private func patternButtonTapped(_ sender: UIButton) {
          updatePattern(button: sender.tag)
    }

    private func updatePattern(button: Int) {

        switch button {
        case 0:
            guard let layout = layout1 else { return }
            currentLayout = layout
        case 1:
            guard let layout = layout2 else { return }
            currentLayout = layout
        case 2:
            guard let layout = layout3 else { return }
            currentLayout = layout
        default: break
        }
        updatePatternButtons(buttonTapped: button)
        displayPattern.addSubview(currentLayout)
        addLayoutConstraint(parentView: displayPattern, childView: currentLayout)
      }

    private func updatePatternButtons(buttonTapped: Int ) {
        for button in 0...2 {
        if button == buttonTapped {
                patternButton[button].setImage(
                    UIImage(named: "Selected.png"), for: .normal)
            } else {
                patternButton[button].setImage(nil, for: .normal)
            }
        }
    }

    ///methode belong to protocol magePickerDelegate
    ///get image from imagePickerController
    internal func didSelectImage(image: UIImage?) {
        ///display image to the right location
        guard let myImage = image else { return }
        currentLayout.displayImage(myImage, at: didImageButtonTapped)
    }

    internal func didImageButtonTapped1(sender: UIButton) {
        //memorize the  location of the futur image
        didImageButtonTapped = 0
        //Display PickerController
        imagePicker.present(from: sender, presentationController: self)
    }

    internal func didImageButtonTapped2(sender: UIButton) {
        didImageButtonTapped = 1
        //Display PickerController
        imagePicker.present(from: sender, presentationController: self)
    }

    internal func didImageButtonTapped3(sender: UIButton) {
        didImageButtonTapped = 2
        //Display PickerController
        imagePicker.present(from: sender, presentationController: self)
    }

    internal func didImageButtonTapped4(sender: UIButton) {
        didImageButtonTapped = 3
        //Display PickerController
        imagePicker.present(from: sender, presentationController: self)
    }

    // override of the methode to detect a new device orientation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        updateOrientation()
    }

    /// updateOrientation
    /// define the current mode according to the height and width
    private func updateOrientation() {
        let height =  UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width

        if  height > width {
            deviceOrientation = .portrait
        } else {
            deviceOrientation = .landscape
        }
    }

    ///manage swipe gesture (up && left)
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .up),
            ( deviceOrientation == .portrait ) {
            let screenHeight = UIScreen.main.bounds.height
            var translationTransform: CGAffineTransform

            //move the view to the top
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
            animatePattern(transform: translationTransform)
        }

        if (sender.direction == .left),
            (deviceOrientation == .landscape) {
            let screenWidth = UIScreen.main.bounds.width
            var translationTransform: CGAffineTransform

            //move the view to the left
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
            animatePattern(transform: translationTransform)
        }
    }

    ///capture image pattern and bring up the ActivityViewController
    private func displayActivityViewController() -> UIActivityViewController {
        let myPattern = self.captureImageFromDisplayPattern(self.displayPattern)
        let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)

        activityController.modalTransitionStyle = .flipHorizontal
        activityController.excludedActivityTypes = .some([
            .addToReadingList,
            .markupAsPDF,
            .print,
            .postToWeibo,
            .postToTencentWeibo]
        )
        //bring up the controller
        self.present(activityController, animated: true, completion: nil)
        return activityController
    }

    private func animateBackToOrigin() {
        // get back the view at the end
        let translationTransform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 1, animations: {
            self.displayPattern.transform = translationTransform
        }, completion: nil)
    }

    private func animatePattern(transform: CGAffineTransform) {
        UIView.animate(withDuration: 1, animations: {
        self.displayPattern.transform = transform }, completion: { _ in
            let activityController = self.displayActivityViewController()
            activityController.completionWithItemsHandler = {(type, completed, items, error) in
                self.animateBackToOrigin()
                }
            })
    }

    /// capture an image of the view in parameter
    /// view:  name of the view.
    private func captureImageFromDisplayPattern(_ viewPattern: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: viewPattern.bounds.size)
        let capturedImage = renderer.image {_ in
            guard let myView = view else { return }
            myView.drawHierarchy(in: viewPattern.bounds, afterScreenUpdates: true)
        }
        return capturedImage
    }

    ///define constraints for layouts inside container displayPattern
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

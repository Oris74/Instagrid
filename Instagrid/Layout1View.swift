//
//  Layout1View.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 01/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class Layout1View: UIView, ManageLayout {

    weak var delegate: ViewDelegate?

    @IBOutlet private weak var imageButton1: UIButton!
    @IBOutlet private weak var imageButton2: UIButton!
    @IBOutlet private weak var imageButton3: UIButton!

    @IBOutlet private var images: [UIImageView]! {
        didSet {
            self.images!.forEach { $0.contentMode = .scaleAspectFill }
        }
    }

    @IBAction private func imageButton1Tapped(_ sender: UIButton) {
        delegate!.didImageButtonTapped1(sender: sender)
       }

    @IBAction private func imageButton2Tapped(_ sender: UIButton) {
        delegate!.didImageButtonTapped2(sender: sender)
    }

    @IBAction private func imageButton3Tapped(_ sender: UIButton) {
        delegate!.didImageButtonTapped3(sender: sender)
    }

    func displayImage(_ image: UIImage, at button: Int) {
        self.images[button].image = image
    }
}

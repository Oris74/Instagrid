//
//  Layout2View.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 01/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

class Layout2View: UIView, ManageLayout {

    weak var delegate: ViewDelegate?

    @IBOutlet private weak var imageButton1: UIButton!
    @IBOutlet private weak var imageButton2: UIButton!
    @IBOutlet private weak var imageButton3: UIButton!

    @IBOutlet private var images: [UIImageView]! {
        didSet {
            self.images.forEach { $0.contentMode = .scaleAspectFill }
        }
    }

    @IBAction private func imageButton1Tapped(_ sender: UIButton) {
        guard let unpackedDelegate = delegate else { return }
        unpackedDelegate.didImageButtonTapped1(sender: sender)
    }

    @IBAction private func imageButton2Tapped(_ sender: UIButton) {
        guard let unpackedDelegate = delegate else { return }
        unpackedDelegate.didImageButtonTapped2(sender: sender)
    }

    @IBAction private func imageBbutton3Tapped(_ sender: UIButton) {
        guard let unpackedDelegate = delegate else { return }
        unpackedDelegate.didImageButtonTapped3(sender: sender)
    }

    func displayImage(_ image: UIImage, at button: Int) {
        self.images[button].image = image
    }
}

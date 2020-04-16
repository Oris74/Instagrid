//
//  ImagePicker.swift
//  Instagrid
//
//  Created by Laurent Debeaujon on 07/04/2020.
//  Copyright © 2020 Laurent Debeaujon. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    func didSelectImage(image: UIImage?)
}

class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    weak var presentationController: UIViewController?
    weak var delegate: ImagePickerDelegate?

    public override init() {
        self.pickerController = UIImagePickerController()

        super.init()

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }

  public func present(from sourceView: UIView) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
       
    self.pickerController.sourceType = .photoLibrary
        self.presentationController?.present(self.pickerController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelectImage image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelectImage(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.pickerController(picker, didSelectImage: nil)
        }

        public func imagePickerController(_ picker: UIImagePickerController,
                                          didFinishPickingMediaWithInfo info:
                                        [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                return self.pickerController(picker, didSelectImage: nil)
            }
            self.pickerController(picker, didSelectImage: image)
        }
}

extension ImagePicker: UINavigationControllerDelegate {
  }

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

open class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    weak var presentationController: UIViewController?
    weak var delegate: ImagePickerDelegate?

    public override init() {
        self.pickerController = UIImagePickerController()

        super.init()

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.presentationController?.present(alertController, animated: true)
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
            guard let image = info[.editedImage] as? UIImage else {
                return self.pickerController(picker, didSelectImage: nil)
            }
            self.pickerController(picker, didSelectImage: image)
        }
}

    extension ImagePicker: UINavigationControllerDelegate {

    }

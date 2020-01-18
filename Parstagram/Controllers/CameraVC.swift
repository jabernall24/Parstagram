//
//  CameraVC.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/10/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.delegate = self
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Post")
        
        guard let postImage = imageView.image else {
            performOkayAlertWith(title: "No image selected", message: "An image is needed in a post, please select one and try again later")
            return
        }
        
        let imageData = postImage.pngData()
        let file = PFFileObject(data: imageData!)
        
        
        post["image"] = file
        post["caption"] = commentTextField.text!
        post["author"] = PFUser.current()!
        
        post.saveInBackground { [weak self] success, error in
            guard let self = self else { return }
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(String(describing: error))")
                self.performOkayAlertWith(title: "Error", message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true)
    }

}

extension CameraVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension CameraVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

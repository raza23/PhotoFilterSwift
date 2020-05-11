//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Raza Shareef on 5/11/20.
//  Copyright © 2020 raza_s. All rights reserved.
// Test test test
// Done

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let context = CIContext()
    var original: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    @IBAction func choosePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            Built in swift method that gives permission to use User's photos
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker,animated: true,completion: nil)
        }
    }
    
    @IBAction func applySepia(){
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        filter?.setValue(CIImage(image:original), forKey:kCIInputImageKey )
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    @IBAction func applyChrome(){
        guard let original = original else {
            return
        }
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        filter?.setValue(CIImage(image:original), forKey:kCIInputImageKey )
        filter?.setValue(CIColor(red: 0, green: 7.8, blue: 9.7), forKey: kCIInputColorKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }


}


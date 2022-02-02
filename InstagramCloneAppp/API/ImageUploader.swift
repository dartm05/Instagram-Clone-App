//
//  ImageUploader.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 18/01/22.
//

import Foundation
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void ){
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        reference.putData(imageData, metadata: nil){ metadata, error in
            
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
            }
            
            reference.downloadURL{ (url, error) in
                guard let imageUrl = url?.absoluteString else{ return }
                completion(imageUrl)
                
            }
            
        }
    }
}

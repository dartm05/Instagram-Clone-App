//
//  AuthService.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 18/01/22.
//

import Foundation
import UIKit
import Firebase
struct AuthCredentials {
    
    let email: String
    let password: String
    let name: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?) -> Void){
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email, "fullname": credentials.name, "profileImageUrl": imageUrl, "uid":uid , "username": credentials.username]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
    
    static func loginUser(withEmail email: String, password:String, completion: AuthDataResultCallback?){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
}

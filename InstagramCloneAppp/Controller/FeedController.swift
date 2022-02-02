//
//  FeedController.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 14/01/22.
//

import Foundation
import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    @objc func handleLogOut(){
        
         do{
             try
                 Auth.auth().signOut()
                     let controller = LoginController()
                     let nav = UINavigationController(rootViewController: controller)
                     nav.modalPresentationStyle = .fullScreen
                     self.present(nav, animated: true, completion: nil)
             
             }
             catch {
                 print("Failed to sign out")
             }
    }
    
    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogOut))
        
        navigationItem.title = "Feed"
    }
    
}
    
    extension FeedController {
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 15
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
           
            return cell
        }
    }

extension FeedController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40  + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}


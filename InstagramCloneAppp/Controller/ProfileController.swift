//
//  ProfileController.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 14/01/22.
//

import Foundation
import UIKit

private let profileCelID = "profile"
private let headerID = "Profileheader"

class ProfileController : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK - Helpers
    
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCelID)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
}

// MARK - UICollectionViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProfileCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCelID, for: indexPath) as! ProfileCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableCell(withReuseIdentifier: headerID, for: indexPath) as! ProfileHeader
        return header
    }
}

// MARK - UICollectionViewDelegate

extension ProfileController {
    
}


// MARK - UICollectionVieDelegateFlowLayout

extension ProfileController {
    
}

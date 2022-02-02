//
//  ProfileHeader.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 18/01/22.
//

import Foundation
import UIKit


class ProfileHeader : UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

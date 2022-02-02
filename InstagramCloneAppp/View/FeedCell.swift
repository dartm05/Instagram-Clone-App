//
//  FeedCell.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 16/01/22.
//

import Foundation
import UIKit

class FeedCell : UICollectionViewCell{
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
        return imageView
    }()
    
    private lazy var userNameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageview : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
        return imageView
        
    }()
    
    private lazy var commentButton : UIButton = {
        
        let commentButton = UIButton(type: .system)
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        commentButton.tintColor = .black
        return commentButton
    }()
    
    private lazy var shareButton : UIButton = {
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "send2"), for: .normal)
        shareButton.tintColor = .black
        return shareButton
    }()
    
    private lazy var likeButton : UIButton = {
        
        let likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
        likeButton.tintColor = .black
        return likeButton
    }()

    private lazy var likeLabel : UILabel = {
        
        let likeLabel = UILabel()
        likeLabel.text = "1 Like"
        likeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return likeLabel
    }()
    
    private lazy var captionLabel : UILabel = {
        
        let likeLabel = UILabel()
        likeLabel.text = "Some caption"
        likeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return likeLabel
    }()
    
    private lazy var postTimeLabel : UILabel = {
        
        let likeLabel = UILabel()
        likeLabel.text = "2 Days ago"
        likeLabel.textColor = .lightGray
        likeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return likeLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
       
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageview)
        postImageview.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 8)
        
        postImageview.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        configureActionButtons()
        
        addSubview(likeLabel)
        likeLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likeLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8 ,paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapUsername(){
        print("tap")
    }
    
    func configureActionButtons(){
        let stackview = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        
        addSubview(stackview)
        stackview.anchor(top: postImageview.bottomAnchor, width: 120, height: 50)
    }
}

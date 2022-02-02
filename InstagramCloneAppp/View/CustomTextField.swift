//
//  CustomTextField.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 17/01/22.
//

import Foundation
import UIKit


class CustomTextField : UITextField {
    
    init(placeholder: String){
        super.init(frame: .zero)
        
     
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        keyboardType = .emailAddress
        keyboardAppearance = .dark
        borderStyle = .none
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

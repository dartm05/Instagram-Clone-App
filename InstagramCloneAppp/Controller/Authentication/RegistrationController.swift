//
//  RegistrationController.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 16/01/22.
//

import Foundation
import UIKit

class RegistrationController : UIViewController {
    
    private var viewmodel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let plushPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"),for: .normal)
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(handlePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    private let emailtextfield : CustomTextField = {
       
        let textfield = CustomTextField(placeholder: "Email")
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    private let passwordtextfield : CustomTextField = {
       
        let textfield = CustomTextField(placeholder: "Password")
        textfield.keyboardType = .emailAddress
        return textfield
    }()

    private let nametextfield = CustomTextField(placeholder: "Full name")
    private let usernametextfield = CustomTextField(placeholder: "Username")
    
    private let signUpButton : UIButton = {
        
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        signUpButton.layer.cornerRadius = 5
        signUpButton.setHeight(50)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return signUpButton
        
    }()
    
    
    private let haveaccount : UIButton = {
        
        let button = UIButton(type: .system)
        button.attributedTittle(op1: "Already have an account?", op2: "Sign In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
    }
    
    @objc func handleLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange( sender: UITextField){
        print("text change")
        if(sender == emailtextfield){print("email")
            viewmodel.email = sender.text
        }
        else if sender == passwordtextfield{
            viewmodel.password = sender.text
        }
        else if sender == usernametextfield{
            viewmodel.username = sender.text
        }
        else{
            viewmodel.fullname = sender.text
        }

        updateForm()
    }
    
    @objc func handlePhotoSelect(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        
        guard let email = emailtextfield.text else {return}
        guard let password = passwordtextfield.text else {return}
        guard let username = usernametextfield.text?.lowercased() else {return}
        guard let name = nametextfield.text else {return}
        guard let profileImage = self.profileImage else {return}
        
        let authCredentials = AuthCredentials(email: email, password: password, name: name, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredentials:  authCredentials) { error in
           if let error = error{
                print("Failed to register user \(error.localizedDescription)")
               return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func configureUI(){
        configureGradient()
        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view)
        plushPhotoButton.setDimensions(height: 140, width: 140)
        plushPhotoButton.anchor(top:view.safeAreaLayoutGuide.topAnchor , paddingTop: 20)
        
        let stackview = UIStackView(arrangedSubviews: [emailtextfield,passwordtextfield,nametextfield,usernametextfield, signUpButton])
        
        stackview.axis = .vertical
        stackview.spacing = 20
        view.addSubview(stackview)
        stackview.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)

        view.addSubview(haveaccount)
        haveaccount.centerX(inView: view)
        haveaccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObserver(){
        emailtextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nametextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernametextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordtextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension RegistrationController: FormViewModel {
    func updateForm(){
        
        signUpButton.backgroundColor = viewmodel.buttonBackgroundColor
        signUpButton.setTitleColor(viewmodel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewmodel.formIsValid
    }
}

 // MARK: - UIImagePickerDelegate

extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageSelected = info[.editedImage] as? UIImage else {return}
        profileImage = imageSelected
        
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor
        plushPhotoButton.layer.borderWidth = 2
        plushPhotoButton.setImage(imageSelected.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}

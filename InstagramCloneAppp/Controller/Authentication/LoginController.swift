//
//  LoginController.swift
//  InstagramCloneAppp
//
//  Created by Daniella Arteaga on 16/01/22.
//

import Foundation
import UIKit

class LoginController : UIViewController {
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
    }
    
    private let iconImage : UIImageView = {
       
        let image = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    private let emailtextfield : CustomTextField = {
       
        let textfield = CustomTextField(placeholder: "Email")
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    
    private let passwordtextfield : CustomTextField = {
       
        let textfield = CustomTextField(placeholder: "Password")
        textfield.isSecureTextEntry = true

        return textfield
    }()
   
    private let loginButton : UIButton = {
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        loginButton.isEnabled = false
        loginButton.layer.cornerRadius = 5
        loginButton.setHeight(50)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return loginButton
        
    }()
    
    private let donthaveaccount : UIButton = {
        
        let button = UIButton(type: .system)
        button.attributedTittle(op1: "Don't have an account?", op2: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private let forgotaccount : UIButton = {
        
        let button = UIButton(type: .system)
        button.attributedTittle(op1: "Forgot your password?", op2: "Get help signing in")
        return button
    }()
    
    
    @objc func handleSignUp(){
        print("Sign up")
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange( sender: UITextField){
        print("text change")
        if(sender == emailtextfield){print("email")
            viewModel.email = sender.text
        }
        else{
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func handleLogin(){
        
        guard let email = emailtextfield.text else {return}
        guard let password = passwordtextfield.text else {return}
        
        AuthService.loginUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to login use \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        configureGradient()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 22)
        
        
        let stackview = UIStackView(arrangedSubviews: [emailtextfield, passwordtextfield, loginButton])
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        stackview.spacing = 20
        view.addSubview(stackview)
        stackview.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor , right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(donthaveaccount)
        donthaveaccount.centerX(inView: view)
        donthaveaccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor )
        
        view.addSubview(forgotaccount)
        forgotaccount.centerX(inView: view)
        forgotaccount.anchor(top: loginButton.bottomAnchor )
        
    }
    
    //Target for textfields for vm data binding
    
    func configureNotificationObserver(){
        emailtextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordtextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension LoginController: FormViewModel {
    func updateForm(){
        
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

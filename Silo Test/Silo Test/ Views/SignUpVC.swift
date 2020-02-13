//
//  SignUpVC.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth

class SignUpVC: UIViewController , LoginButtonDelegate{

    @IBOutlet weak var btnFB: FBLoginButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setText();

    }

    func setText(){
         let buttonText = NSAttributedString(string: "Sign in with Facebook")
        
         btnFB.setAttributedTitle(buttonText, for: .normal)
        
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
               if result?.token != nil{
        let credential = FacebookAuthProvider.credential(withAccessToken: (result?.token!.tokenString)!)
               Auth.auth().signIn(with: credential) { (authResult, error) in
                   if(error == nil){
                        UserDefaults.standard.setValue("true", forKey: "LoggedStatus")
              let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SiloMapVC") as! SiloMapVC
                     self.navigationController?.setViewControllers([viewController], animated: false)
                   }
                }}
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }

}

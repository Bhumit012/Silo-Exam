//
//  SiloViewController.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-09.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Foundation

class SiloViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserLoged()
    }
    func isUserLoged(){
          let userLoggedIn =  UserDefaults.standard.value(forKey: "LoggedStatus") as? String
            
             if(userLoggedIn != nil && userLoggedIn != "false"){
               let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                  let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SiloMapVC") as! SiloMapVC
                                     self.navigationController?.setViewControllers([viewController], animated: false)
             }
        
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        let SignUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
       let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
              self.navigationController?.pushViewController(signInVC, animated: true)
    }
}

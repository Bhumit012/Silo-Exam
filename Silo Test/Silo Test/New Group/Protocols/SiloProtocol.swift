//
//  SiloProtocol.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import Foundation
import UIKit

protocol SiloViewProtocol: class {
    var presenter: SiloPresenterProtocol! { get set }
    
}

protocol SiloPresenterProtocol: class {
    var view: SiloViewProtocol? { get set }
    func viewDidLoad()
    func signUpPressed()
    func signInpressed()
}

protocol SiloRouterProtocol {
    func pushVC(VCid:String)
    func setNewVC(VCid:String)
}

protocol SiloInteractorInputProtocol {
  //  var presenter: UsersInteractorOutputProtocol? { get set }
    func getUsers()
}

protocol SiloInteractorOutputProtocol: class {

}

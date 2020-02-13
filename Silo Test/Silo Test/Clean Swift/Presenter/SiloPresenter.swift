//
//  SiloPresenter.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-09.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//


import Foundation

class SiloPresenter:SiloPresenterProtocol {
    
    
    var presenter: SiloPresenterProtocol!
    weak var view: SiloViewProtocol?
    private let interactor: SiloInteractorInputProtocol
    private let router: SiloRouterProtocol
    // configure the presenter
    init(view: SiloViewProtocol, interactor: SiloInteractorInputProtocol, router: SiloRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    func signUpPressed() {
        self.router.pushVC(VCid: "SignUpVC")
    }
    
    func signInpressed() {
        self.router.pushVC(VCid: "SignInVC")
    }
    
    func viewDidLoad() {
        
    }
    
    
}


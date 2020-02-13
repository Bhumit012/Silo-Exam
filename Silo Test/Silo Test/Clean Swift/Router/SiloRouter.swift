//
//  SiloRouter.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-09.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//


import UIKit
import Foundation

class SiloRouter: SiloRouterProtocol{
    func pushVC(VCid: String) {
       // let view = SiloRouter.mainStoryboard.instantiateViewController(withIdentifier: VCid)
       // viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func setNewVC(VCid: String) {
        
    }

    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "\(SiloViewController.self)") as! SiloViewController
       // let interactor = SiloInteractor()
        let router = SiloRouter()
       // let presenter = SiloPresenter(view: view, interactor: interactor, router: router)
     //   view.presenter = presenter
        //interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
}

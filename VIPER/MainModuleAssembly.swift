//
//  MainModuleAssembly.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation
import UIKit

class MainModuleAssembly {
    class func configureModule() -> UIViewController {
        let view = СalculatorViewController()
        
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()
        let arrayEntitie = PhysicalActivityEntitie.arrayPhysicalActivity
        
        view.output = presenter
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        interactor.arrayPhysicalActivityEntitie = arrayEntitie
        interactor.gettingAnArray()
        
        router.viewController = view
        
        return view
    }
}

//
//  Presenter.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation

protocol PresenterInterfase: AnyObject {
    func getDataByIndex(_ index: Int) -> PhysicalActivity?
    var getItemCount: Int { get }
}

class Presenter: ViewOutput, InteractorOutput, PresenterInterfase {
    
    weak var view: ViewInput!
    var interactor: InteractorInput!
    var router: RouterInput!
    var array = [PhysicalActivityEntitie]()
   
    //MARC: - PresenterInterfase
    func getDataByIndex(_ index: Int) -> PhysicalActivity? {
        array[index]
    }
    
    var getItemCount: Int {
        return array.count
    }
    
    //MARC: - InteractorOutput
    
    func passingAnArray(_ array: [PhysicalActivityEntitie]) {
        self.array = array
    }
    
    func result(_ toSaveWeight: String, forWeightLoss: String, forFastWeightLoss: String) {
        router.showResultAlert(toSaveWeight, forWeightLoss: forWeightLoss, forFastWeightLoss: forFastWeightLoss)
        view.clearFields()
    }
    
    func error(_ error: String?) {
        router.showErrorAlert(error)
    }
    
    func genderResulr(_ isMan: Bool, isWomen: Bool) {
        view.colorizeGenderButtons(isMan, isWomen: isWomen)
    }
    
    //MARC: - ViewOutput
    func didPressedButtonMen() {
        interactor.isMen()
    }
    
    func didPressedButtonWoman() {
        interactor.isWoman()
    }
    
    func didPressedButtonCalculateCalories(_ textAge: String?,
                                           textHeight: String?,
                                           textTheWeight: String?,
                                           physicalActivityEntitie: PhysicalActivity?) {
        
        interactor?.calorieСalculation(textAge,
                                       textHeight: textHeight,
                                       textTheWeight: textTheWeight,
                                       physicalActivityEntitie: physicalActivityEntitie)
    }
}

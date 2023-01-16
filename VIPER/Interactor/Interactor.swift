//
//  Interactor.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation

protocol InteractorInput: AnyObject {
    func gettingAnArray()
    
    func isMen()
    func isWoman()
    func calorieСalculation(_ textAge: String?,
                            textHeight: String?,
                            textTheWeight: String?,
                            physicalActivityEntitie: PhysicalActivity?)
}

protocol InteractorOutput: AnyObject {
    func passingAnArray(_ array: [PhysicalActivityEntitie])
    func error(_ error: String?)
    func result(_ toSaveWeight: String,
                forWeightLoss: String,
                forFastWeightLoss: String)
    func genderResulr(_ isMan: Bool, isWomen: Bool)
}

class Interactor: InteractorInput {
   
    weak var output: InteractorOutput!
    var arrayPhysicalActivityEntitie = [PhysicalActivityEntitie]()
    
    private enum ErrorСalculation: String {
        case genderNotSpecified = "Не указан пол!!!"
        case ageNotSpecified = "Возраст не указан!!!"
        case heightNotSpecified = "Рост не указан!!!"
        case weightNotSpecified = "Вес не указан!!!"
        case wrongFormat = "В одном из полей указан не подходящий формат!!!"
        case physicalActivityNotSpecified = "Ошибка физической активность!!!"
    }
    
    private var isMan = false
    private var isWomen = false
    
    //MARC: - InteractorInput
    func gettingAnArray() {
        output?.passingAnArray(arrayPhysicalActivityEntitie)
    }
    
    func isMen() {
        isMan = true
        isWomen = false
        output?.genderResulr(true, isWomen: false)
    }
    
    func isWoman() {
        isMan = false
        isWomen = true
        output?.genderResulr(false, isWomen: true)
    }
    
    
    func calorieСalculation(_ textAge: String?,
                            textHeight: String?,
                            textTheWeight: String?,
                            physicalActivityEntitie: PhysicalActivity?) {
        
        guard isMan != false || isWomen != false else {
            output?.error(ErrorСalculation.genderNotSpecified.rawValue)
            return
        }
        
        guard let textAge = textAge, textAge != "" else {
            output?.error(ErrorСalculation.ageNotSpecified.rawValue)
            return
        }
        guard let age = Double(textAge) else {
            output?.error(ErrorСalculation.wrongFormat.rawValue)
            return
        }
        
        guard let textTheWeight = textTheWeight, textTheWeight != "" else {
            output?.error(ErrorСalculation.heightNotSpecified.rawValue)
            return
        }
        guard let theWeight = Double(textTheWeight) else {
            output?.error(ErrorСalculation.wrongFormat.rawValue)
            return
        }
        
        
        guard let textHeight = textHeight, textHeight != "" else {
            output?.error(ErrorСalculation.heightNotSpecified.rawValue)
            return
        }
        guard let height = Double(textHeight) else {
            output?.error(ErrorСalculation.wrongFormat.rawValue)
            return
        }
        
        guard let physicalActivityEntitie = physicalActivityEntitie else {
            output?.error(ErrorСalculation.physicalActivityNotSpecified.rawValue)
            return
        }
            
            var genderValue = 0.0
        if isMan == true {
            genderValue = 5.0
        } else {
            genderValue = -161.0
        }
        
        var calorieToSaveWeight = Int((10 * theWeight + 6.25 * height - 5 * age + genderValue)
                                      * physicalActivityEntitie.multiplier)
        var calorieForWeightLoss = Int((10 * theWeight + 6.25 * height - 5 * age + genderValue)
                                       * physicalActivityEntitie.multiplier - 250)
        var calorieForFastWeightLoss = Int((10 * theWeight + 6.25 * height - 5 * age + genderValue)
                                           * physicalActivityEntitie.multiplier - 500)
        
        if isMan == true {
            if calorieToSaveWeight < 1400 {
                calorieToSaveWeight = 1400
            }
            if calorieForWeightLoss < 1400 {
                calorieForWeightLoss = 1400
            }
            if calorieForFastWeightLoss < 1400 {
                calorieForFastWeightLoss = 1400
            }
        } else {
            if  calorieToSaveWeight < 1200 {
                calorieToSaveWeight = 1200
            }
            if  calorieForWeightLoss < 1200 {
                calorieForWeightLoss = 1200
            }
            if  calorieForFastWeightLoss < 1200 {
                calorieForFastWeightLoss = 1200
            }
        }
        
        output?.result(String(calorieToSaveWeight) + " кал",
                       forWeightLoss: String(calorieForWeightLoss) + " кал",
                       forFastWeightLoss: String(calorieForFastWeightLoss) + " кал")
        
        isMan = false
        isWomen = false
    }
}

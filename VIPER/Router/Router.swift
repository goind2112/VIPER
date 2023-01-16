//
//  Router.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation
import UIKit

protocol RouterInput: AnyObject {
    func showErrorAlert(_ error: String?)
    func showResultAlert(_ toSaveWeight: String, forWeightLoss: String, forFastWeightLoss: String )
}

class Router: RouterInput {
    
    weak var viewController: UIViewController!
    
    func showErrorAlert(_ error: String?) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
    
    func showResultAlert(_ toSaveWeight: String, forWeightLoss: String, forFastWeightLoss: String) {
        
        let textAlert =        
"""
Для сохраниения веса: \(toSaveWeight)
Для похудения: \(forWeightLoss)
Для быстрого похудения: \(forFastWeightLoss)
"""
        
        let attributedStringForTitle = NSAttributedString(string: "Результат:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        let attributedStringForMessage = NSAttributedString(string: textAlert, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.setValue(attributedStringForTitle, forKey: "attributedTitle")
        alert.setValue(attributedStringForMessage, forKey: "attributedMessage")
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
}

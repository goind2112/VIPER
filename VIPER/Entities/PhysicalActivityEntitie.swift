//
//  PhysicalActivity.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation

struct PhysicalActivityEntitie: PhysicalActivity {
    var physicalActivityName: String
    var multiplier: Double
    var physicalActivityTag: Int
    
    static let arrayPhysicalActivity = [
        PhysicalActivityEntitie(physicalActivityName: "Минимум/отсутствие",
                         multiplier: 1.2,
                         physicalActivityTag: 1),
        PhysicalActivityEntitie(physicalActivityName: "Слабая активность",
                         multiplier: 1.375,
                         physicalActivityTag: 2),
        PhysicalActivityEntitie(physicalActivityName: "Средняя активность",
                         multiplier: 1.55,
                         physicalActivityTag: 3),
        PhysicalActivityEntitie(physicalActivityName: "Высокая активность",
                         multiplier: 1.725,
                         physicalActivityTag: 4),
        PhysicalActivityEntitie(physicalActivityName: "Очень высокая активность",
                         multiplier: 1.9,
                         physicalActivityTag: 5),
    ]
}

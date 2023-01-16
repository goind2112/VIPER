//
//  PickerRow.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 13.01.2023.
//

import Foundation
import UIKit
import SnapKit

class PickerRow: UIView {
    
    lazy var physicalActivityLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 17)
        
        return label
    }()
    
    static func setupPickerRow(with arrayPhysicalActivity: PhysicalActivity) -> PickerRow {
        let pickerRow = PickerRow()
        pickerRow.physicalActivityLabel.text = arrayPhysicalActivity.physicalActivityName
        return pickerRow
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(physicalActivityLabel)
        
        physicalActivityLabel.snp.makeConstraints { make in
            //to do:
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

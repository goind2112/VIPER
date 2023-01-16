//
//  СalculatorViewController.swift
//  VIPER
//
//  Created by Даниил Мухсинятов on 12.01.2023.
//

import UIKit
import SnapKit 

protocol PhysicalActivity {
    var physicalActivityName: String { get set }
    var multiplier: Double { get set }
    var physicalActivityTag: Int { get set }
}

protocol ViewInput: AnyObject {

    func colorizeGenderButtons(_ isMan: Bool, isWomen: Bool)
    func clearFields()
}

protocol ViewOutput: AnyObject {
    func didPressedButtonMen()
    func didPressedButtonWoman()
    func didPressedButtonCalculateCalories(_ textAge: String?,
                                           textHeight: String?,
                                           textTheWeight: String?,
                                           physicalActivityEntitie: PhysicalActivity?
    )
}

class СalculatorViewController: UIViewController, ViewInput {
    
    private lazy var physicalActivity = presenter.getDataByIndex(0)
    var presenter: PresenterInterfase!
    var output: ViewOutput!
    
    // MARC: - name screen
    private lazy var labelScreenName = createLabel(with: 20, textAlignment: .center)
    
    // MARC: - age
    private lazy var labelAge = createLabel(with: 17, textAlignment: .left)
    private lazy var textFieldAge = createTextField()
    
    // MARC: - sex
    private lazy var labelSex = createLabel(with: 17, textAlignment: .left)
    private lazy var labelMen = createLabel(with: 17, textAlignment: .left)
    
    private lazy var buttonMen: UIButton = {
        let button = UIButton()
        
        button.imageView?.tintColor = .gray
        button.addTarget(self,
                         action: #selector(buttonMenPressed),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelWoman = createLabel(with: 17, textAlignment: .left)
    
    private lazy var buttonWoman: UIButton = {
        let button = UIButton()
        
        button.imageView?.tintColor = .gray
        button.addTarget(self,
                         action: #selector(buttonWomanPressed),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARC: - height
    private lazy var labelHeight = createLabel(with: 17, textAlignment: .left)
    private lazy var textFieldHeight = createTextField()
    
    // MARC: - weight
    private lazy var labelTheWeight = createLabel(with: 17, textAlignment: .left)
    private lazy var textFieldTheWeight = createTextField()
    private lazy var labelThePhysicalActivity = createLabel(with: 17, textAlignment: .center)
    
    // MARC: - physical activity
    private lazy var pickerViewPhysicalActivity: UIPickerView = {
        let picker = UIPickerView()
        
        picker.layer.cornerRadius = 15
        
        return picker
    }()
    
    // MARC: - button calculate calories
    private lazy var buttonCalculateCalories: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self,
                         action: #selector(buttonCalculateCaloriesPressed),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARC: - keyboard hide button
    private let buttonHideKeyboard: UIButton = {
        let button = UIButton(type: .system)
        
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.addTarget(self,
                         action: #selector(hideKeyboard),
                         for: .touchUpInside)
        
        return button
    }()
    
    //MARC: - functions are called when the keyboard appears and disappears
    @objc func keyboardShow() {
        buttonHideKeyboard.isHidden = false
    }
    
    @objc func keyboardHide() {
        buttonHideKeyboard.isHidden = true
    }
    
    //MARC: - button pressed functions
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func buttonMenPressed() {
        output?.didPressedButtonMen()
    }
    @objc
    func buttonWomanPressed() {
        output?.didPressedButtonWoman()
    }
    @objc
    func buttonCalculateCaloriesPressed() {
        let textAge = textFieldAge.text
        let textHeight = textFieldHeight.text
        let textTheWeight = textFieldTheWeight.text
        output?.didPressedButtonCalculateCalories(textAge,
                                                  textHeight: textHeight,
                                                  textTheWeight: textTheWeight,
                                                  physicalActivityEntitie: physicalActivity)
    }
    
    //MARC: - ViewInput
    
    func colorizeGenderButtons(_ isMan: Bool, isWomen: Bool) {
        if isMan == true {
            buttonMen.imageView?.tintColor = .systemBlue
            buttonWoman.imageView?.tintColor = .gray
        } else {
            buttonMen.imageView?.tintColor = .gray
            buttonWoman.imageView?.tintColor = .systemBlue
        }
    }
    
    func clearFields() {
        textFieldAge.text = ""
        textFieldHeight.text = ""
        textFieldTheWeight.text = ""
        pickerViewPhysicalActivity.selectRow(0, inComponent: 0, animated: true)
        physicalActivity = presenter.getDataByIndex(0)
        pickerViewPhysicalActivity.reloadAllComponents()
        buttonMen.imageView?.tintColor = .gray
        buttonWoman.imageView?.tintColor = .gray
    }
    
    //MARC: - functions for customization СalculatorViewController
    func addSubviews() {
        
        
        // MARC: - name Screen
        view.addSubview(labelScreenName)
        
        // MARC: - age
        view.addSubview(labelAge)
        view.addSubview(textFieldAge)
        
        // MARC: - sex
        view.addSubview(labelSex)
        view.addSubview(labelMen)
        view.addSubview(buttonMen)
        view.addSubview(labelWoman)
        view.addSubview(buttonWoman)
        
        // MARC: - height
        view.addSubview(labelHeight)
        view.addSubview(textFieldHeight)
        
        // MARC: - weight
        view.addSubview(labelTheWeight)
        view.addSubview(textFieldTheWeight)
        
        // MARC: - physical activity
        view.addSubview(labelThePhysicalActivity)
        view.addSubview(pickerViewPhysicalActivity)
        
        // MARC: - button calculate calories
        view.addSubview(buttonCalculateCalories)
        
        // MARC: - keyboard hide button
        view.addSubview(buttonHideKeyboard)
    }
    
    func layoutSubviews() {
        
        // MARC: - name screen
        labelScreenName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(10)
        }
        
        // MARC: - age
        labelAge.snp.makeConstraints { make in
            make.top.equalTo(labelScreenName).inset(45)
            make.left.equalToSuperview().inset(10)
        }
        labelAge.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        textFieldAge.snp.makeConstraints { make in
            make.top.equalTo(labelScreenName).inset(40)
            make.left.equalTo(labelAge.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        textFieldAge.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // MARC: - sex
        labelSex.snp.makeConstraints { make in
            make.top.equalTo(labelAge.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        labelMen.snp.makeConstraints { make in
            make.top.equalTo(labelSex.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
        }
        
        buttonMen.snp.makeConstraints { make in
            make.top.equalTo(labelSex.snp.bottom).offset(20)
            make.left.equalTo(labelMen.snp.right).offset(10)
        }
        
        labelWoman.snp.makeConstraints { make in
            make.top.equalTo(labelSex.snp.bottom).offset(20)
            make.left.equalTo(buttonMen.snp.right).offset(10)
        }
        
        buttonWoman.snp.makeConstraints { make in
            make.top.equalTo(labelSex.snp.bottom).offset(20)
            make.left.equalTo(labelWoman.snp.right).offset(10)
        }
        
        // MARC: - height
        labelHeight.snp.makeConstraints { make in
            make.top.equalTo(labelMen.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(10)
        }
        labelHeight.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        textFieldHeight.snp.makeConstraints { make in
            make.top.equalTo(labelMen.snp.bottom).offset(20)
            make.left.equalTo(labelHeight.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        textFieldHeight.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // MARC: - weight
        labelTheWeight.snp.makeConstraints { make in
            make.top.equalTo(labelHeight.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(10)
        }
        labelTheWeight.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        textFieldTheWeight.snp.makeConstraints { make in
            make.top.equalTo(labelHeight.snp.bottom).offset(20)
            make.left.equalTo(labelTheWeight.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        textFieldTheWeight.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // MARC: - physical activity
        labelThePhysicalActivity.snp.makeConstraints { make in
            make.top.equalTo(labelTheWeight.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        pickerViewPhysicalActivity.snp.makeConstraints { make in
            make.top.equalTo(labelThePhysicalActivity.snp.bottom).offset(20)
            make.left.right.equalToSuperview().offset(10)
        }
        
        // MARC: - button calculate calories
        buttonCalculateCalories.snp.makeConstraints { make in
            make.top.equalTo(pickerViewPhysicalActivity.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        // MARC: - keyboard hide button
        buttonHideKeyboard.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        
        view.keyboardLayoutGuide.snp.makeConstraints { make in
            make.top.equalTo(buttonHideKeyboard.snp.bottom)
            make.right.equalTo(buttonHideKeyboard.snp.right)
        }
        
    }
    
    func configure() {
        labelScreenName.text          = "Калькулятор каллорий"
        labelAge.text                 = "Возраст:"
        labelSex.text                 = "Пол"
        labelMen.text                 = "Муж"
        labelWoman.text               = "Жен"
        labelHeight.text              = "Рост:"
        labelTheWeight.text           = "Вес:"
        labelThePhysicalActivity.text = "Физическая активность"
        
        buttonMen.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
        buttonWoman.setImage(UIImage(systemName: "smallcircle.filled.circle"), for: .normal)
        buttonCalculateCalories.setTitle("Расчитать", for: .normal)
        buttonHideKeyboard.setTitle("Скрыть", for: .normal)
        
        pickerViewPhysicalActivity.delegate = self
        pickerViewPhysicalActivity.dataSource = self
        monitoringTheStateOfTheKeyboard()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutSubviews()
        configure()
        view.backgroundColor = .systemMint
    }


}

extension СalculatorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getItemCount
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let row = presenter.getDataByIndex(row) else { return UIView() }
        return PickerRow.setupPickerRow(with: row)
    }
}

extension СalculatorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row = presenter.getDataByIndex(row)
        physicalActivity = row
    }
}

extension СalculatorViewController {
    
    func createLabel(with size: CGFloat, textAlignment: NSTextAlignment?) -> UILabel {
        let label: UILabel = {
            let label = UILabel()
            
            label.textColor = .black
            label.textAlignment = textAlignment ?? .left
            label.font = UIFont(name: "Helvetica", size: size)
            
            return label
        }()
        return label
    }
    
    func createTextField() -> UITextField {
        let textField: UITextField = {
            let textField = UITextField()
            
            textField.borderStyle = .roundedRect
            textField.textColor = .black
            textField.font = UIFont(name: "Helvetica", size: 17)
            textField.keyboardType = .numberPad
            
            return textField
        }()
        return textField
    }
    
}

extension СalculatorViewController {
    func monitoringTheStateOfTheKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

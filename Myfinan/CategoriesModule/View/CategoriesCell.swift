//
//  CategoriesCell.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
    //reuse id
    static let reuseId = "KidsCell"
    
    lazy var kidNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var kidAgeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Возраст"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var removeKidButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Удалить"
        configuration.baseForegroundColor = .systemBlue
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CategoriesCell.reuseId)
        
        self.selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        
        addSubview(kidNameField)
        kidNameField.translatesAutoresizingMaskIntoConstraints = false
        kidNameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        kidNameField.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        kidNameField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        kidNameField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        
        addSubview(kidAgeField)
        kidAgeField.translatesAutoresizingMaskIntoConstraints = false
        kidAgeField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        kidAgeField.topAnchor.constraint(equalTo: kidNameField.bottomAnchor, constant: 10).isActive = true
        kidAgeField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        kidAgeField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        
        addSubview(removeKidButton)
        removeKidButton.translatesAutoresizingMaskIntoConstraints = false
        removeKidButton.leadingAnchor.constraint(equalTo: kidNameField.trailingAnchor, constant: 10).isActive = true
        removeKidButton.centerYAnchor.constraint(equalTo: kidNameField.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


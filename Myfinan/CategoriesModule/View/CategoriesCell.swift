//
//  CategoriesCell.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
    //reuse id
    static let reuseId = "CategoriesCell"
    
    lazy var categoriesCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CategoriesCell.reuseId)
        
        self.selectionStyle = .default
        self.contentView.isUserInteractionEnabled = true
        self.accessoryType = .disclosureIndicator
        
        addSubview(categoriesCardView)
        categoriesCardView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        categoriesCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        categoriesCardView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        categoriesCardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        categoriesCardView.addSubview(categoriesLabel)
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        categoriesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoriesLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        categoriesLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


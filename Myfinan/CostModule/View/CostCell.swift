//
//  CostTableViewCell.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 29.03.2022.
//

import UIKit

class CostCell: UITableViewCell {
    
    //reuse id
    static let reuseId = "CostCell"
    
    //1 layer
    lazy var categoriesCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    //2 layer
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var costLabel: UILabel = {
        let label = UILabel()
//        label.text = "Oplata 100 rub"
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
//        label.text = "This is comment"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CategoriesCell.reuseId)
        
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
        
        addSubview(categoriesCardView)
        categoriesCardView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        categoriesCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        categoriesCardView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        categoriesCardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        categoriesCardView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        categoriesCardView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        costLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        
        categoriesCardView.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        commentLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 10).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

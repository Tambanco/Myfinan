//
//  CategoriesViewController.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    lazy var categoriesVC: CategoriesViewProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesVC = CategoriesView()
    
    }

}

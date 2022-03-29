//
//  ModuleBuilder.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import Foundation
import UIKit
import CoreData

protocol Builder: AnyObject {
    static func createCategoriesModule() -> UITableViewController
    static func createCostModule() -> UITableViewController
}

class ModuleBuilder: Builder {
    
    
    static func createCategoriesModule() -> UITableViewController {
        let view = CategoriesTableViewController()
        let model = Categories()
        let presenter = CategoriesPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
    static func createCostModule() -> UITableViewController {
        let view = CostViewController()
        let model = CostModel(time: "10:00", cost: "Оплата 100 в категории Еда", comment: "Магнит молоко")
        let presenter = CostPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}

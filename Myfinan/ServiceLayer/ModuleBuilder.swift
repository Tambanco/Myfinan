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
    static func createCostModule(cost: CostModel?) -> UITableViewController
}

class ModuleBuilder: Builder {
    
    
    static func createCategoriesModule() -> UITableViewController {
        let view = CategoriesTableViewController()
        let model = Categories()
        let presenter = CategoriesPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
    static func createCostModule(cost: CostModel?) -> UITableViewController {
        let view = CostViewController()
        let model = CostModel(time: cost?.time, cost: cost?.cost, comment: cost?.comment)
        let presenter = CostPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}

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
    static func createCostModule(titleOfHeader: String?) -> UITableViewController
}

class ModuleBuilder: Builder {
    
    static let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    static func createCategoriesModule() -> UITableViewController {
        let view = CategoriesController()
        let categories = [Category]()
        let presenter = CategoriesPresenter(view: view, categories: categories, context: context)
        view.presenter = presenter
        return view
    }
    
    static func createCostModule(titleOfHeader: String?) -> UITableViewController {
        let view = CostViewController()
        let cost = [Cost]()
        let presenter = CostPresenter(view: view, cost: cost, title: titleOfHeader, context: context)
        view.presenter = presenter
        return view
    }
}

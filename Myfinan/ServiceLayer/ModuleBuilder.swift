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
        let model = [Category]()
        let presenter = CategoriesPresenter(view: view, model: model, context: context)
        view.presenter = presenter
        return view
    }
    
    static func createCostModule(titleOfHeader: String?) -> UITableViewController {
        let view = CostViewController()
        let model = [Cost]()
        let presenter = CostPresenter(view: view, model: model, title: titleOfHeader, context: context)
        view.presenter = presenter
        return view
    }
}

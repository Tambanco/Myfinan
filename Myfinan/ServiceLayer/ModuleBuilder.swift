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
}

class ModuleBuilder: Builder {
    static func createCategoriesModule() -> UITableViewController {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let view = CategoriesTableViewController()
        let model = Categories(context: context)
        let presenter = CategoriesPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}

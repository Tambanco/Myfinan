//
//  ModuleBuilder.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import Foundation
import UIKit

protocol Builder: AnyObject {
   static func createCategoriesModule() -> UITableViewController
}

class ModuleBuilder: Builder {
    static func createCategoriesModule() -> UITableViewController {
        let view = CategoriesTableViewController()
        let model = CategoriesModel(category: ["cat1", "cat2", "cat3"])
        let presenter = CategoriesPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}

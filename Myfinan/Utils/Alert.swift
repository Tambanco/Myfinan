//
//  Alert.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 10.04.2022.
//

import UIKit
import CoreData

enum Alert {
    
    static func addNewCategory(title: String, massage: String, actionTitle: String, cancelTitle: String, context: NSManagedObjectContext, categories: [Category], view: CategoriesViewProtocol?) {
        
        var updatedCategories = categories
        let alert = UIAlertController(title: "Добавьте новую категорию", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите категорию"
            alertTextField.autocapitalizationType = .sentences
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let newCategory = Category(context: context)
            newCategory.name = alert.textFields?.first?.text ?? "999"
            updatedCategories.append(newCategory)
            view?.setCategories(categories: updatedCategories, categoryName: newCategory.name)
            CoreDataManager.sharedManager.saveContext()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        alert.addAction(addAction)
        view?.present(viewControllerToPresent: alert)
    }
    
    static func editModel(title: String, massage: String, actionTitle: String, cancelTitle: String, indexPath: IndexPath, context: NSManagedObjectContext, categories: [Category], view: CategoriesViewProtocol?) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.text = categories[indexPath.row].name
            alertTextField.autocapitalizationType = .sentences
        }
        
        let addAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let updatedValue = alert.textFields?.first?.text ?? "222"
            categories[indexPath.row].name = updatedValue
            view?.setCategories(categories: categories, categoryName: updatedValue)
            context.name = updatedValue
            CoreDataManager.sharedManager.saveContext()
            
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        view?.present(viewControllerToPresent: alert)
    }
}

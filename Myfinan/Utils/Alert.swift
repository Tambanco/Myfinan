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
    
    static func addNewCost(categoryTitle: String?, firstPlaceholder: String, secondPlaceholder: String, title: String, actionTitle: String, cancelTitle: String, context: NSManagedObjectContext, cost: [Cost], view: CostViewProtocol?) {
        var updatedCosts = cost
        guard let currentTitleOfCost = categoryTitle else { return }
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите сумму"
            //добавить валидацию
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Комментарий"
            alertTextField.autocapitalizationType = .sentences
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let newCost = Cost(context: context)
            let today = Date()
            let hours   = (Calendar.current.component(.hour, from: today))
            let minutes = (Calendar.current.component(.minute, from: today))
            // тут баг где не видно 0 во значении вермени 21:6
            newCost.timeMark = "\(hours):\(minutes)"
            newCost.label = "Оплата \(alert.textFields?[0].text ?? "999") рублей за \(currentTitleOfCost)"
            newCost.comment = alert.textFields?[1].text ?? "99"
            newCost.category = "\(currentTitleOfCost)"
            updatedCosts.append(newCost)
            view?.setCost(cost: updatedCosts)
            CoreDataManager.sharedManager.saveContext()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        view?.presentCostVC(viewControllerToPresent: alert)
    }
}

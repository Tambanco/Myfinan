//
//  CategoriesPresenter.swift
//  Myfinan
//
//  Created tambanco 🥳 on 21.03.2022.
//
//  Template generated by Tambanco
//

import Foundation
import UIKit
import CoreData

// MARK: Output protocol
protocol CategoriesViewProtocol: AnyObject {
    func setCategories(categories: [Category])
    func configureAddButton(addButton: UIBarButtonItem)
    func present(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol CategoriesPresenterProtocol: AnyObject {
    init(view: CategoriesViewProtocol, categories:  [Category])
    func showCategories()
    func showAddButton()
    func editModel(indexPath: IndexPath, newTitle: String)
    func updateModel(indexPath: IndexPath)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    
    var categories: [Category] = [Category]()
    weak var view: CategoriesViewProtocol?
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func editModel(indexPath: IndexPath, newTitle: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.text = newTitle
            alertTextField.autocapitalizationType = .sentences
        }
        
        let addAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let updatedCategory = Category(context: self.context)
            let newCostTitle = Cost(context: self.context)
            let updatedTextField = alert.textFields?.first?.text ?? "222"
            updatedCategory.name = updatedTextField
            newCostTitle.category = updatedTextField
            self.categories[indexPath.row].name = updatedTextField
            self.view?.setCategories(categories: self.categories)
            CoreDataManager.sharedManager.saveContext()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        self.view?.present(viewControllerToPresent: alert)
    }
    
    func showAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        self.view?.configureAddButton(addButton: addItem)
    }
    
    @objc func addCategory() {
        let alert = UIAlertController(title: "Добавьте новую категорию", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите категорию"
            alertTextField.autocapitalizationType = .sentences
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let newCategory = Category(context: self.context)
            newCategory.name = alert.textFields?.first?.text ?? "999"
            self.categories.append(newCategory)
            self.view?.setCategories(categories: self.categories)
            CoreDataManager.sharedManager.saveContext()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        alert.addAction(addAction)
        self.view?.present(viewControllerToPresent: alert)
    }
    
    func updateModel(indexPath: IndexPath) {
        context.delete(categories[indexPath.row])
        do {
            try context.save()
        } catch {
            print("Error saving context \(error.localizedDescription)")
        }
        categories.remove(at: indexPath.row)
        self.view?.setCategories(categories: categories)
    }
    
    func showCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                categories = try context.fetch(request)
            } catch {
                print("Error fetching request \(error.localizedDescription)")
            }
        self.view?.setCategories(categories: categories)
    }
    
    required init(view: CategoriesViewProtocol, categories: [Category]) {
        self.view = view
        self.categories = categories
    }
}

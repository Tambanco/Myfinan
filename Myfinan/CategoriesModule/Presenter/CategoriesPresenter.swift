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
    func setCategories(categories: [Categories])
    func configureAddButton(addButton: UIBarButtonItem)
    func present(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol CategoriesPresenterProtocol: AnyObject {
    init(view: CategoriesViewProtocol, model:  Categories)
    func showCategories()
    func showAddButton()
    func updateModel(indexPath: IndexPath)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    weak var view: CategoriesViewProtocol?
    var model: Categories!
    var categories = [Categories]()
    
    func showAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        self.view?.configureAddButton(addButton: addItem)
    }
    
    @objc func addCategory() {
        var categoryTextField = UITextField()
        let alert = UIAlertController(title: "Добавьте новую категорию", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите категорию"
            alertTextField.autocapitalizationType = .sentences
            categoryTextField = alertTextField
        }
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            let newCategory = Categories(context: context)
            newCategory.category = categoryTextField.text ?? "999"
            self.categories.append(newCategory)
            self.view?.setCategories(categories: self.categories)
            CoreDataManager.sharedManager.saveContext()
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(action)
//        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .systemBlue
//        alert.view.tintColor = .white
        self.view?.present(viewControllerToPresent: alert)
    }
    
    func updateModel(indexPath: IndexPath) {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
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
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest<Categories> = Categories.fetchRequest()
            do {
                categories = try context.fetch(request)
            } catch {
                print("Error fetching request \(error.localizedDescription)")
            }
        self.view?.setCategories(categories: categories)
    }
    
    required init(view: CategoriesViewProtocol, model: Categories) {
        self.view = view
        self.model = model
    }
}

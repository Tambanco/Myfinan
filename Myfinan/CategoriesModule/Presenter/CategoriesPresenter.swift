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
    init(view: CategoriesViewProtocol, categories:  [Category], context: NSManagedObjectContext)
    func showCategories()
    func showAddButton()
    func updateModel(indexPath: IndexPath)
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    var categories: [Category] = [Category]()
    weak var view: CategoriesViewProtocol?
    var context: NSManagedObjectContext!
    
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
            newCategory.title = alert.textFields?.first?.text ?? "999"
            self.categories.append(newCategory)
            self.view?.setCategories(categories: self.categories)
            CoreDataManager.sharedManager.saveContext()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        alert.addAction(addAction)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .systemTeal
        alert.view.tintColor = .black
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
    
    required init(view: CategoriesViewProtocol, categories: [Category], context: NSManagedObjectContext) {
        self.view = view
        self.categories = categories
        self.context = context
    }
}

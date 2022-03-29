//
//  CostPresenter.swift
//  Myfinan
//
//  Created tambanco 🥳 on 29.03.2022.
//
//  Template generated by Tambanco
//

import Foundation
import UIKit
import CoreData

// MARK: Output protocol
protocol CostViewProtocol: AnyObject {
    func setCost(cost: [Cost])
    func configureAddButton(addButton: UIBarButtonItem)
    func present(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol CostPresenterProtocol: AnyObject {
    init(view: CostViewProtocol, model:  Cost)
    func showCost()
    func showAddButton()
    func updateModel(indexPath: IndexPath)
}

class CostPresenter: CostPresenterProtocol {
    
    weak var view: CostViewProtocol?
    var model: Cost!
    var cost = [Cost]()
    
    func showAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCost))
        self.view?.configureAddButton(addButton: addItem)
    }
    
    @objc func addCost() {
        let alert = UIAlertController(title: "Добавьте новую категорию", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите категорию"
            alertTextField.autocapitalizationType = .sentences
        }

        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            let newCost = Cost(context: context)
            newCost.mark = alert.textFields?.first?.text ?? "999"
            self.cost.append(newCost)
            self.view?.setCost(cost: self.cost)
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
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        context.delete(cost[indexPath.row])
        do {
            try context.save()
        } catch {
            print("Error saving context \(error.localizedDescription)")
        }
        cost.remove(at: indexPath.row)
        self.view?.setCost(cost: cost)
    }
    
    func showCost() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request: NSFetchRequest<Cost> = Cost.fetchRequest()
            do {
                cost = try context.fetch(request)
            } catch {
                print("Error fetching request \(error.localizedDescription)")
            }
        self.view?.setCost(cost: [model])
    }

    required init(view: CostViewProtocol, model: Cost) {
        self.view = view
        self.model = model
    }
}

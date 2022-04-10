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
    func setTitle(title: String?)
    func configureAddButton(addNewCost: UIBarButtonItem)
    func presentCostVC(viewControllerToPresent: UIViewController)
}

// MARK: Input protocol
protocol CostPresenterProtocol: AnyObject {
    init(view: CostViewProtocol, cost:  [Cost], title: String?)
    func showCost()
    func showTitle()
    func showAddButton()
    func removeModelItems(indexPath: IndexPath)
}

class CostPresenter: CostPresenterProtocol {
    
    weak var view: CostViewProtocol?
    var cost: [Cost] = [Cost]()
    var title: String?
    var context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    func showTitle() {
        self.view?.setTitle(title: title)
    }
    
    func showAddButton() {
        let addNewCost = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCost))
        self.view?.configureAddButton(addNewCost: addNewCost)
    }
    
    @objc func addCost() {
        Alert.addNewCost(categoryTitle: title, firstPlaceholder: "Введите сумму", secondPlaceholder: "Комментарий", title: "", actionTitle: "Добавить", cancelTitle: "Отмена", context: context, cost: cost, view: view)
    }
    
    func removeModelItems(indexPath: IndexPath) {
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
        guard let currentTitle = title else { return }
        let request: NSFetchRequest<Cost> = Cost.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "category == %@", "\(currentTitle)")
        request.predicate = predicate
            do {
                cost = try context.fetch(request)
            } catch {
                print("Error fetching request \(error.localizedDescription)")
            }
        self.view?.setCost(cost: cost)
    }

    required init(view: CostViewProtocol, cost: [Cost], title: String?) {
        self.view = view
        self.cost = cost
        self.title = title
    }
}

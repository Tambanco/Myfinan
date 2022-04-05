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
    init(view: CostViewProtocol, cost:  [Cost], title: String?, context: NSManagedObjectContext)
    func showCost()
    func showTitle()
    func showAddButton()
    func updateModel(indexPath: IndexPath)
}

class CostPresenter: CostPresenterProtocol {
    
    weak var view: CostViewProtocol?
    var cost: [Cost] = [Cost]()
    var title: String?
    var context: NSManagedObjectContext!
    
    func showTitle() {
        self.view?.setTitle(title: title)
    }
    
    func showAddButton() {
        let addNewCost = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCost))
        self.view?.configureAddButton(addNewCost: addNewCost)
    }
    
    @objc func addCost() {
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
            let newCost = Cost(context: self.context)
            let today = Date()
            let hours   = (Calendar.current.component(.hour, from: today))
            let minutes = (Calendar.current.component(.minute, from: today))
            newCost.timeMark = "\(hours):\(minutes)"
            newCost.label = "Оплата \(alert.textFields?[0].text ?? "999") рублей за \(self.title ?? "111")"
            newCost.comment = alert.textFields?[1].text ?? "99"
            self.cost.append(newCost)
            self.view?.setCost(cost: self.cost)
            CoreDataManager.sharedManager.saveContext()
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .systemTeal
        alert.view.tintColor = .black
        self.view?.presentCostVC(viewControllerToPresent: alert)
    }
    
    func updateModel(indexPath: IndexPath) {
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
        let fetchRequest: NSFetchRequest<Cost> = Cost.fetchRequest()
        let predicate = NSPredicate(format: "comment == %@", "Foo")
        fetchRequest.predicate = predicate
        
            do {
                cost = try context.fetch(fetchRequest)
            } catch {
                print("Error fetching request \(error.localizedDescription)")
            }
        self.view?.setCost(cost: cost)
    }

    required init(view: CostViewProtocol, cost: [Cost], title: String?, context: NSManagedObjectContext) {
        self.view = view
        self.cost = cost
        self.title = title
        self.context = context
    }
}

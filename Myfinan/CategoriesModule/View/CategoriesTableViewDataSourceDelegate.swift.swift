//
//  CategoriesTableViewDataSourceDelegate.swift.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 29.03.2022.
//

import Foundation
import UIKit

extension CategoriesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.reuseId, for: indexPath) as! CategoriesCell
        cell.categoriesLabel.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteCategory = UIContextualAction(style: .normal, title: "") { _, _, completionHandler in
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.presenter.removeModelItems(indexPath: indexPath)
            self.tableView.endUpdates()
            completionHandler(true)
        }
        let deleteImage = UIImage(systemName: "trash")
        deleteCategory.image = deleteImage
        deleteCategory.backgroundColor = .systemRed
        
        let editCategory = UIContextualAction(style: .normal, title: "") { _, _, completionHandler in
            self.tableView.beginUpdates()
            self.presenter.editModel(indexPath: indexPath)
            self.tableView.endUpdates()
            completionHandler(true)
        }
        let editImage = UIImage(systemName: "pencil")
        editCategory.image = editImage
        editCategory.backgroundColor = .systemTeal
        
        return UISwipeActionsConfiguration(actions: [deleteCategory,editCategory])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryTitle = categories[indexPath.row].name
        let costVC = ModuleBuilder.createCostModule(titleOfHeader: categoryTitle)
        navigationController?.pushViewController(costVC, animated: true)
    }
}

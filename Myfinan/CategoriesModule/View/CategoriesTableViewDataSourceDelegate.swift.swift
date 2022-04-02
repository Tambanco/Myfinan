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
        cell.categoriesLabel.text = categories[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.presenter.updateModel(indexPath: indexPath)
            self.tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryTitle = categories[indexPath.row].title
        let costVC = ModuleBuilder.createCostModule(titleOfHeader: categoryTitle)
        navigationController?.pushViewController(costVC, animated: true)
    }
}

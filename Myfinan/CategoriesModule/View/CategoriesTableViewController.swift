//
//  CategoriesTableViewController.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var presenter: CategoriesPresenterProtocol!
    var categoriesArray: [String]!
    var navBarAppearance = UINavigationBarAppearance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.showCategories()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.showNavigationBar()
        self.presenter.showAddButton()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.reuseId)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.reuseId, for: indexPath) as! CategoriesCell
        cell.categoriesLabel.text = categoriesArray[indexPath.row]
        return cell
    }
}

// MARK: - Binding
extension CategoriesTableViewController: CategoriesViewProtocol {
    func present(viewControllerToPresent: UIViewController) {
        self.present(viewControllerToPresent, animated: true)
    }
    
    func configureAddButton(addButton: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        self.navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        self.navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        self.navBarAppearance.backgroundColor = backgoundColor
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationItem.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
    }
    
    func setCategories(categories: [String]) {
        categoriesArray = categories
        tableView.reloadData()
    }
}

//
//  CategoriesTableViewController.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesController: UITableViewController {
    
    // MARK: - Properties
    var presenter: CategoriesPresenterProtocol!
    var categories: [Category] = []
    var categoryTitle: String?

    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.showCategories()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.showAddButton()
        self.setupNavBar(preferredLargeTitle: true, title: "Категории", tintColor: .white, titleTextColor: .white, backgoundColor: .systemBlue, cornerRadius: 20)
    }

    // MARK: - TableView
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: CategoriesCell.reuseId)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    // MARK: - NavigationBar
    func setupNavBar(preferredLargeTitle: Bool, title: String, tintColor: UIColor, titleTextColor: UIColor, backgoundColor: UIColor, cornerRadius: CGFloat) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleTextColor]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleTextColor]
            navBarAppearance.backgroundColor = backgoundColor
            navBarAppearance.shadowColor = nil
            
            self.title = title
            self.self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.setStatusBar(backgroundColor: backgoundColor)
            self.navigationController?.navigationBar.layer.cornerRadius = cornerRadius
            self.navigationController?.navigationBar.layer.masksToBounds = true
            self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        }
    }
}

// MARK: - Binding
extension CategoriesController: CategoriesViewProtocol {
    
    func present(viewControllerToPresent: UIViewController) {
        self.present(viewControllerToPresent, animated: true)
    }
    
    func configureAddButton(addButton: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func setCategories(categories: [Category], categoryName: String?) {
        self.categories = categories
        self.categoryTitle = categoryName
        tableView.reloadData()
    }
}

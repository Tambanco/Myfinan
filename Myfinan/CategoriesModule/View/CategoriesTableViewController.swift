//
//  CategoriesTableViewController.swift
//  Myfinan
//
//  Created by tambanco 🥳 on 21.03.2022.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var presenter: CategoriesPresenterProtocol!
    var categoriesArray: [Categories]!

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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.reuseId, for: indexPath) as! CategoriesCell
        cell.categoriesLabel.text = categoriesArray[indexPath.row].category
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
extension CategoriesTableViewController: CategoriesViewProtocol {
    
    func present(viewControllerToPresent: UIViewController) {
        self.present(viewControllerToPresent, animated: true)
    }
    
    func configureAddButton(addButton: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func setCategories(categories: [Categories]) {
        categoriesArray = categories
        tableView.reloadData()
    }
}

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}

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
//        super.viewWillAppear(animated)
        self.presenter.showAddButton()
//        self.setNeedsStatusBarAppearanceUpdate()
        self.setupNavBar(preferredLargeTitle: true, title: "Категории", translucent: true, tintColor: .black, largeTitleColor: .black, backgoundColor: .systemPink)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
    
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
    func setupNavBar(preferredLargeTitle: Bool, title: String, translucent: Bool, tintColor: UIColor, largeTitleColor: UIColor, backgoundColor: UIColor) {
        
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .systemOrange
            navBarAppearance.shadowColor = nil
            
            self.navigationController?.navigationBar.layer.cornerRadius = 20
            self.navigationController?.navigationBar.layer.masksToBounds = true

            self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.title = "fff"
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }

//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.backgroundColor = .systemOrange
//        self.navigationController?.navigationBar.layer.cornerRadius = 20
//        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        self.title = "Категории"
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//        self.navigationController?.navigationBar.barTintColor = .systemOrange
        
        
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        self.navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
//        self.title = title
//        self.navigationController?.navigationBar.isTranslucent = translucent
//        self.navigationController?.navigationBar.tintColor = tintColor
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.backgroundColor = backgoundColor
//
//        let shadowView = UIView(frame: CGRect(x: 0, y: -50, width: (self.navigationController?.navigationBar.bounds.width)!,
//                                                            height: (self.navigationController?.navigationBar.bounds.height)! + 50))
//        shadowView.backgroundColor = .white
//
//        self.navigationController?.navigationBar.insertSubview(shadowView, at: 1)
//
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds,
//                                        byRoundingCorners: [.bottomLeft, .bottomRight],
//                                        cornerRadii: CGSize(width: 20, height: 20)).cgPath
//        shadowLayer.fillColor = UIColor.white.cgColor
//        shadowLayer.shadowColor = UIColor.darkGray.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        shadowLayer.shadowOpacity = 0.8
//        shadowLayer.shadowRadius = 2
//        shadowView.layer.insertSublayer(shadowLayer, at: 0)
        
        
//        var navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
//        navBarAppearance.backgroundColor = backgoundColor
//
//        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.compactAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.backgroundColor = UIColor.white
//
//        //4. Add shadow and cirner radius to navbar
//         let shadowView = UIView(frame: CGRect(x: 0, y: -20,
//                                            width: (self.navigationController?.navigationBar.bounds.width)!,
//                                            height: (self.navigationController?.navigationBar.bounds.height)! + 20))
//         shadowView.backgroundColor = UIColor.white
//         self.navigationController?.navigationBar.insertSubview(shadowView, at: 1)
//
//         let shadowLayer = CAShapeLayer()
//         shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
//
//         shadowLayer.fillColor = UIColor.white.cgColor
//
//         shadowLayer.shadowColor = UIColor.darkGray.cgColor
//         shadowLayer.shadowPath = shadowLayer.path
//         shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//         shadowLayer.shadowOpacity = 0.8
//         shadowLayer.shadowRadius = 2
//
//         shadowView.layer.insertSublayer(shadowLayer, at: 0)
//        self.navigationController?.navigationBar.tintColor = tintColor
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationItem.title = title
//        self.navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
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

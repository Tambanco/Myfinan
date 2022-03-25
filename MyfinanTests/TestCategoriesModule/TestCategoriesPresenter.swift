//
//  TestCategoriesPresenter.swift
//  MyfinanTests
//
//  Created by tambanco 🥳 on 25.03.2022.
//

import XCTest
@testable import Myfinan

class MockView: CategoriesViewProtocol {
    
    var categoriesArray: [Categories]?
    
    
    func setCategories(categories: [Categories]) {
        self.categoriesArray = categories
    }
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        
    }
    
    func configureAddButton(addButton: UIBarButtonItem) {
        
    }
    
    func present(viewControllerToPresent: UIViewController) {
        
    }
    
}

class TestCategoriesPresenter: XCTestCase {
    
    var view: MockView!
    var categories: Categories!
    var presenter: CategoriesPresenter!

    override func setUpWithError() throws {
        view = MockView()
//        categories = Categories(context: <#T##NSManagedObjectContext#>)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}

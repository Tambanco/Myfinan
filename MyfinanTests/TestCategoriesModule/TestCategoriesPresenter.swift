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
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        view = MockView()
        categories = Categories(context: context)
        presenter = CategoriesPresenter(view: view, model: categories)
    }

    override func tearDownWithError() throws {
        view = nil
        categories = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(categories, "person is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
}

//
//  CocktailUITests.swift
//  CocktailUITests
//
//  Created by Abdul Rahim on 08/11/21.
//

import XCTest

class CocktailUITests: XCTestCase {

    /// search bar test
    func test_search_drink() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let searchDrinksSearchField = app.searchFields["Search drinks"]
        searchDrinksSearchField.tap()
        searchDrinksSearchField.typeText("Moj")
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Mojito").element.tap()
    }
    
    
    ///  collectionview scroll test
    func test_collectionview_vertical_scroll() throws {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"ABC").element.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"747").element.swipeUp()
        
        let verticalScrollBar5PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 5 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 5 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar5PagesCollectionView.swipeUp()
        verticalScrollBar5PagesCollectionView.swipeDown()
        cellsQuery.otherElements.containing(.staticText, identifier:"Smut").element.tap()
        app.navigationBars["Smut"].buttons["Let's eat Quality food"].tap()
    }

}

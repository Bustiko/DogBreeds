//
//  DetailsPageUITests.swift
//  DogBreedsUITests
//
//  Created by Buse Karabıyık on 23.01.2025.
//

import XCTest

final class DetailsPageUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testDetailsPage_WhenLaunched_ToolbarItemsAppear() throws {
        let randomButton = app.buttons["RandomBreedButton"]
        randomButton.tap()
        
        XCTAssertTrue(app.otherElements["NavigationStack"].images["DetailsToolbarItem-heart"].exists, "Favorite tool bar item does not appear.")
        XCTAssertTrue(app.otherElements["NavigationStack"].images["DetailsToolbarItem-chevron.left"].exists, "Back tool bar item does not appear.")
        
    }
    
    func testDetailsPage_WhenFavoriteButtonPressed_ButtonImageChanges() throws {
        let randomButton = app.buttons["RandomBreedButton"]
        randomButton.tap()
        
        app.otherElements["NavigationStack"].images["DetailsToolbarItem-heart"].tap()
        
        sleep(1)
        
        XCTAssertTrue(app.otherElements["NavigationStack"].images["DetailsToolbarItem-heart.fill"].exists, "Favorite tool bar item image does not get changed when breed added to favorites.")
    }
    
    func testDetailsPage_WhenChevronPressed_ItDisappears() throws {
        let randomButton = app.buttons["RandomBreedButton"]
        randomButton.tap()
        
        app.otherElements["NavigationStack"].images["DetailsToolbarItem-chevron.left"].tap()
        
        sleep(1)
        
        XCTAssertFalse(app.scrollViews["DetailsPageView"].exists, "Details page does not dissapear when chevron pressed.")
        
    }
}

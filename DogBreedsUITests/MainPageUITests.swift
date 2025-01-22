//
//  MainPageUITests.swift
//  DogBreedsUITests
//
//  Created by Buse Karabıyık on 22.01.2025.
//

import XCTest
@testable import DogBreeds
import FirebaseDatabaseInternal

final class MainPageUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMainPage_WhenLaunched_CarouselStartsAutoScroll() throws {
        let carousel = app.collectionViews["CarouselView"]
        
        XCTAssertTrue(carousel.exists, "Carousel should appear.")
        
        let initialCell = carousel.images["CarouselImage-0"]
        XCTAssertTrue(initialCell.exists, "First cell should appear.")
        
        let nextCell = carousel.images["CarouselImage-1"]
        
        sleep(5)
        
        XCTAssertTrue(nextCell.exists, "Second cell should appear after auto-scroll.")
    }

    
    func testMainPage_WhenLaunched_ButtonsAppear() throws {
        let favoritesButton = app.buttons["FavoritesButton"]
        let randomButton = app.buttons["RandomBreedButton"]
        
        XCTAssertTrue(favoritesButton.isEnabled, "Favorites button does not appear on screen.")
        XCTAssertTrue(randomButton.isEnabled, "Favorites button does not appear on screen.")
        
    }
    
    func testMainPage_WhenFavoritesButtonClicked_TextChanges() throws {
        let favoritesButton = app.buttons["FavoritesButton"]
        favoritesButton.tap()
        
        let textView = app.staticTexts["Favorite Breeds"]
        
        XCTAssertTrue(textView.exists, "Text view did not change the text.")
        
    }
    
    func testMainPage_WhenRandomBreedButtonClicked_DetailsPageAppear() throws {
        let randomButton = app.buttons["RandomBreedButton"]
        randomButton.tap()
        
        sleep(1)
        
        let detailsPageView = app.scrollViews["DetailsPageView"]
        XCTAssertTrue(detailsPageView.exists, "Details page did not appear.")
    }
}

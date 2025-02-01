//
//  ApodChallengeUITests.swift
//  ApodChallengeUITests
//
//  Created by Andre Lemos on 2025-01-31.
//

import XCTest

final class ApodChallengeUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }


    func testHomeTitleDisplay() { //Checks if the title is being presented

        let homeTitleText = app.staticTexts["title.home"]
            
        // Check if the title text is visible
        XCTAssertTrue(homeTitleText.exists)
    }
    
    func testLoadingDisplay() {
        
        let loadingText = app.staticTexts["loading"]
        
        // Check if the loading text is invisible
        XCTAssertFalse(loadingText.waitForExistence(timeout: 15))

    }
    
    func testNavigationToDetailView() {
        //Executes the action of tapping the button
        let detailButton = app.buttons["DetailViewButton"]
        XCTAssertTrue(detailButton.exists)
        detailButton.firstMatch.tap()

        // Checks if you've navigated to the DetailView
        let aboutUsViewTitle = app.staticTexts["title.detail"]
        XCTAssertTrue(aboutUsViewTitle.waitForExistence(timeout: 5))
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

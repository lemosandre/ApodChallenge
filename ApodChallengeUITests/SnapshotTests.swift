//
//  SnapshotTests.swift
//  ApodChallenge
//
//  Created by Andre Lemos on 2025-02-01.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import ApodChallenge

final class SnapshotTests: XCTestCase {
    
    let today = Date.now
    let formatter = DateFormatter()
    
    func testHomeViewRecursiveDescription() {
        let homeView = HomeView()
        let view: UIView = UIHostingController(rootView: homeView).view
        
        assertSnapshot(of: view, as: .recursiveDescription)
    }
    
    func testDetailViewRecursiveDescription() {
        formatter.dateFormat = API.DefaultValue.dateFormat
        let detailView = DetailView(date: formatter.string(from: endDate))
        let view: UIView = UIHostingController(rootView: detailView).view
        
        assertSnapshot(of: view, as: .recursiveDescription)
    }
    
    func testHomeViewImage() {
        let homeView = HomeView()
        let view = UIHostingController(rootView: homeView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhone13))
    }
    
    func testDetailViewImage() {
        formatter.dateFormat = API.DefaultValue.dateFormat
        let detailView = DetailView(date: formatter.string(from: endDate))
        let view = UIHostingController(rootView: detailView)
        
        assertSnapshot(matching: view, as: .image(on: .iPhone13))
    }
    
    func testHomeViewImageiPad() {
        let homeView = HomeView()
        let view = UIHostingController(rootView: homeView)
        
        assertSnapshot(matching: view, as: .image(on: .iPadPro11(.landscape)))
    }
    
    func testDetailViewImageiPad() {
        formatter.dateFormat = API.DefaultValue.dateFormat
        let detailView = DetailView(date: formatter.string(from: endDate))
        let view = UIHostingController(rootView: detailView)
        
        assertSnapshot(matching: view, as: .image(on: .iPadPro11(.landscape)))
    }

    func testHomeViewImageDarkMode() {
        let homeView = HomeView()
        let view = UIHostingController(rootView: homeView)
            
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(
            matching: view,
            as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
    
    func testDetailViewImageDarkMode() {
        formatter.dateFormat = API.DefaultValue.dateFormat
        let detailView = DetailView(date: formatter.string(from: endDate))
        let view = UIHostingController(rootView: detailView)
            
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(
            matching: view,
            as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
}

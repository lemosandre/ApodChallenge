//
//  ApodChallengeTests.swift
//  ApodChallengeTests
//
//  Created by Andre Lemos on 2025-01-31.
//

import XCTest
@testable import ApodChallenge

final class ApodChallengeTests: XCTestCase {
    
    func testGetApodList() {
        let viewModel = HomeViewModel()
        let requestExpectation = expectation(description: "Data is Not Empty")
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date.now)!
        let endDate = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = API.DefaultValue.dateFormat
        
        viewModel.getApodList(
            startDate: formatter.string(from: startDate),
            endDate: formatter.string(from: endDate),
            callBack: {
                if viewModel.apodList.isEmpty {
                    XCTAssertNil("Empty")
                } else {
                    requestExpectation.fulfill()
                }
            }, failure: { error in
                XCTAssertNil(error)
            })
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testGetApod() {
        let viewModel = HomeViewModel()
        let requestExpectation = expectation(description: "API is Return")
        
        viewModel.getApod(
            callBack: {
                requestExpectation.fulfill()
            }, failure: { error in
                XCTAssertNil(error)
            })
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testNetworkArray() {
        let requestExpectation = expectation(description: "API with Array")
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date.now)!
        let endDate = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = API.DefaultValue.dateFormat
        // Network Array
        Network.requestArray(request: Router.apodList(startDate: formatter.string(from: startDate), endDate: formatter.string(from: endDate)), type: Apod.self, completion: { result in
            switch result {
            case .success(let data):
                if data.isEmpty {
                    XCTAssertNil("Array is empty")
                } else {
                    requestExpectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testNetworkObject() {
        let requestExpectation = expectation(description: "API is return")
        // Network Object
        Network.requestObject(request: Router.apod, type: Apod.self, completion: { result in
            switch result {
            case .success(let data):
                requestExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        })
        
        wait(for: [requestExpectation], timeout: 10.0)
    }
}

//
//  MusicSearch_iTunesAPITests.swift
//  MusicSearch_iTunesAPITests
//
//  Created by Shak Feizi on 8/22/21.
//

import XCTest
@testable import MusicSearch_iTunesAPI


class MusicSearch_iTunesAPITests: XCTestCase {
    // Shak notes: Properties
    var session: URLSession?
    var urlBuilder = ResultsController()

    // Shak notes: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        session = nil
    }

    // Shak notes: Functions
    func testValidURL() throws {
        var url = URL(string: "https://itunes.apple.com/search")
        let expectation = expectation(description: "Status Code 200")
        session?.dataTask(with: url!, completionHandler: { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    expectation.fulfill()
                } else {
                    XCTFail("Status Code: \(statusCode)")
                }
            }
        }).resume()
        wait(for: [expectation], timeout: 5)
    }
    
    func testURLForFetchFunction() throws {
        let sourceURL = URLComponents(string: "https://itunes.apple.com/search")
        let expectation = expectation(description: "Correct URL")
        let builtURL = urlBuilder.url
        if builtURL == sourceURL {
            expectation.fulfill()
        } else {
            XCTFail("Wronge URL")
        }
        wait(for: [expectation], timeout: 5)
    }
    
//    func testAPICallCompleted() throws {
//        var url = URL(string: "https://itunes.apple.com/search")
//        let expectation = expectation(description: "Completion handler invoked")
//        var statusCode: Int?
//        var responseError: Error?
//        session?.dataTask(with: url!, completionHandler: { _, response, error in
//            statusCode = (response as? HTTPURLResponse)?.statusCode
//            responseError = error
//            expectation.fulfill()
//        }).resume()
//        wait(for: [expectation], timeout: 5)
//        XCTAssertNil(responseError)
//        XCTAssertEqual(statusCode, 200)
//    }
}

//
//  MusicSearch_iTunesAPITests.swift
//  MusicSearch_iTunesAPITests
//
//  Created by Shak Feizi on 8/22/21.
//

import XCTest
@testable import MusicSearch_iTunesAPI


class MusicSearch_iTunesAPISlowTests: XCTestCase {
    // Shak notes: Properties
    var session: URLSession?
    var urlBuilder = ResultsController()
    let networkMonitor = NetworkMonitor.shared

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
        try XCTSkipUnless(
          networkMonitor.isReachable,
          "Network connectivity needed for this test.")
        let url = URL(string: "https://itunes.apple.com/search?term=musicArtist")
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
    
    func testAPICallCompleted() throws {
        let url = URL(string: "https://itunes.apple.com/search?term=musicArtist")
        let expectation = expectation(description: "Status Code 200")
        var statusCode: Int?
        var responseError: Error?
        session?.dataTask(with: url!, completionHandler: { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expectation.fulfill()
        }).resume()
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}

//
//  mAppTests.swift
//  mAppTests
//
//  Created by Bahadır Enes Atay on 27.07.2021.
//

import XCTest
@testable import mApp
import Alamofire

class mAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeriesEntity() throws {
        XCTAssertNotEqual(ResponseMock().getSeriesCount(), 0, "Content was founded!")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

protocol ResponseGetter {
    func getSeriesCount() -> Int
}

class ResponseMock: ResponseGetter {
    func getSeriesCount() -> Int {
        if let jsonResult = decodeJSONFile(), let series = jsonResult["Search"] as? [Any] {
            cLog(series.count)
            return series.count
        }
        return 0
    }
    
    private func decodeJSONFile() -> Dictionary<String, AnyObject>? {
        if let path = Bundle.main.path(forResource: "series_sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    return jsonResult
                }
            } catch {
                cLog("an error occurred when decoding json file")
            }
        }
        return nil
    }

}

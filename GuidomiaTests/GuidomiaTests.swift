//
//  GuidomiaTests.swift
//  GuidomiaTests
//
//  Created by Razieh Halimi on 2022-08-30.
//

import XCTest
@testable import Guidomia

class GuidomiaTests: XCTestCase {
    
    func testGetData() {
        if let fileLocation = Bundle.main.url(forResource: "data", withExtension: "json"){
            do{
                let content = try Data(contentsOf: fileLocation)
                guard parseJson(content) != nil else {
                    XCTAssertNil(parseJson(content), "no data")
                    return
                }
                if let cars = self.parseJson(content) {
                    XCTAssertTrue(cars.count > 0 )
                }
            }
            catch {
                XCTAssertThrowsError(NetWorkError.decodingError.localizedDescription)
            }
        }
    }
    
    func parseJson(_ data: Data) -> [Car]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Car].self, from: data)
            return decodedData
            
        } catch {
            print(NetWorkError.decodingError.localizedDescription)
            return nil
        }
    }
}

//
//  DataManagerUnitTests.swift
//  DogBreedsTests
//
//  Created by Buse Karabıyık on 23.01.2025.
//

import XCTest
@testable import DogBreeds

final class DataManagerUnitTests: XCTestCase {

    var mockDataManager: MockDataManager!
    
    override func setUpWithError() throws {
        mockDataManager = MockDataManager()
    }

    override func tearDownWithError() throws {
        mockDataManager = nil
    }

    func testDataManager_WhenSuccessfulFetch_ReturnsData() async throws {
        let result: [Dog]? = await mockDataManager.fetchData(from: "MockData", headers: nil)
        
        XCTAssertTrue(mockDataManager.fetchBreedsCalled, "fetchBreedsCalled should be true after calling fetchData.")
        XCTAssertNotNil(result, "fetchData should return a valid result when provided with mock data.")
    }
    
    func testDataManager_WhenInvalidURL_throwsError() {
        let dataManager = DataManager()
        Task {
            do {
                let _: [Dog]? = try await dataManager.fetchData(from: "test")
                XCTFail("Expected to throw an error but succeeded")
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            }
        }
    }
    
    
}

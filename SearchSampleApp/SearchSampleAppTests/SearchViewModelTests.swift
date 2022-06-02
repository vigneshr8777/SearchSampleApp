//
//  SearchSampleAppTests.swift
//  SearchSampleAppTests
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import XCTest
@testable import SearchSampleApp

class SearchSampleAppTests: XCTestCase {
    private var subject: SearchViewModel!

    override func setUp() {
        super.setUp()
        subject = SearchViewModel(withDependency: MockDependency())
    }

    func testGetCellViewModelInvalidIndex() {
        XCTAssertNil(subject.getCellViewModel(atIndex: 10))
    }

    func testGetCellViewModelValidIndex() {
        subject.fetchCities(searchTerm: "") { result in
            switch result {
            case .success(_):
                XCTAssertNotNil(self.subject.getCellViewModel(atIndex: 2))
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testCellViewModels() {
        subject.fetchCities(searchTerm: "") { result in
            switch result {
            case .success(_):
                XCTAssertEqual(self.subject.numberOfItems(), 3)
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.cityName, "test")
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.country, "country")
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.state, "state")
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testError() {
        subject = SearchViewModel(withDependency: MockDependency(error: .unknownError("Unknown error")))
        subject.fetchCities(searchTerm: "") { result in
            switch result {
            case .success(_):
                XCTFail()
            case let .failure(error):
                XCTAssertEqual(error.localizedDescription, "Unknown error")
            }
        }
    }
}

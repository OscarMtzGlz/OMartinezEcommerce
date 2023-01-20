//
//  OMartinezEcommerceTests.swift
//  OMartinezEcommerceTests
//
//  Created by MacBookMBA2 on 17/01/23.
//

import XCTest
@testable import OMartinezEcommerce

final class OMartinezEcommerceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test con GetById con id inexistente
    func testExample() throws {
        let departamentoViewModel = DepartamentoViewModel()
        var result = departamentoViewModel.GetById(idDepartamento: 1)
        XCTAssertTrue(result.Correct)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

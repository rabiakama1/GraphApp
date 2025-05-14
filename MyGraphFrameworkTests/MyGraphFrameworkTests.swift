//
//  MyGraphFrameworkTests.swift
//  MyGraphFrameworkTests
//
//  Created by RABİA KAMA on 13.05.2025.
//

import XCTest
@testable import MyGraphFramework

final class MyGraphFrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFindClosestNode() throws {
        // Sample graph data
        let jsonString = """
        [
            {
                "id": "node1",
                "pointType": "point",
                "edges": [
                    {
                        "id": "node2",
                        "weight": 7.5
                    },
                    {
                        "id": "node3",
                        "weight": 12
                    }
                ]
            },
            {
                "id": "node2",
                "pointType": "wc",
                "edges": [
                    {
                        "id": "node1",
                        "weight": 7.5
                    }
                ]
            },
            {
                "id": "node3",
                "pointType": "point",
                "edges": [
                    {
                        "id": "node1",
                        "weight": 12
                    }
                ]
            }
        ]
        """
        
        let framework = try MyGraphFramework(jsonString: jsonString)
        
        // Test finding closest WC from node1
        if let result = framework.findClosestNode(ofType: "wc", fromNodeId: "node1") {
            XCTAssertEqual(result.node.id, "node2")
            XCTAssertEqual(result.distance, 7.5)
        } else {
            XCTFail("Should have found a WC node")
        }
    }

}

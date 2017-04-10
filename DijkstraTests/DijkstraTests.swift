//
//  DijkstraTests.swift
//  DijkstraTests
//
//  Created by Zafra, Guillermo (Consultant) on 10/04/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest
@testable import Dijkstra

class DijkstraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /*
         A
        / \
       B   C
        \ /
         D
     */
    func test4Nodes() {
        // Setup
        var nodes: [Vertex] = [Vertex(key: "A"), Vertex(key: "B"), Vertex(key: "C"), Vertex(key: "D")]
        
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[1], weight: 1)
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[2], weight: 2)
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes.last!, weight: 10)
        GraphsAlgorithms.addEdge(source: nodes[2], neighbour: nodes.last!, weight: 5)
        
        let shortestPath = GraphsAlgorithms.processDijkstra(source: nodes.first!, destination: nodes.last!)
        XCTAssert(shortestPath != nil)
        XCTAssert(shortestPath!.destination.key == nodes.last!.key)
        XCTAssert(shortestPath!.trail.count == 2)
        XCTAssert(shortestPath!.trail[1].key == "C")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

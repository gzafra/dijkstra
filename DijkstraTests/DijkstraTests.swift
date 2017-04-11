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


    func test4Nodes() {
        let nodes = TestUtilities.sample4Nodes()
        
        let shortestPath = GraphsAlgorithms.processDijkstra(source: nodes.first!, destination: nodes.last!)
        XCTAssert(shortestPath != nil)
        XCTAssert(shortestPath!.destination.key == nodes.last!.key)
        XCTAssert(shortestPath!.trail.count == 2)
        XCTAssert(shortestPath!.trail[1].key == "C")
        XCTAssert(shortestPath!.trail[0].key == "D")
        XCTAssert(shortestPath!.total == 7)
    }
    
    func test5Nodes() {
        let nodes = TestUtilities.sample5Nodes()
        
        let shortestPath = GraphsAlgorithms.processDijkstra(source: nodes.first!, destination: nodes.last!)
        XCTAssert(shortestPath != nil)
        XCTAssert(shortestPath!.destination.key == nodes.last!.key)
        XCTAssert(shortestPath!.trail.count == 2)
        XCTAssert(shortestPath!.trail[1].key == "D")
        XCTAssert(shortestPath!.trail[0].key == "E")
        XCTAssert(shortestPath!.total == 12)
    }
    
    func test9Nodes() {
        let nodes = TestUtilities.sample9Nodes()

        let shortestPath = GraphsAlgorithms.processDijkstra2(source: nodes.first!, destination: nodes.last!)
        XCTAssert(shortestPath != nil)
        XCTAssert(shortestPath!.destination.key == nodes.last!.key)
        XCTAssert(shortestPath!.trail.count == 4)
        XCTAssert(shortestPath!.trail[0].key == "I")
        XCTAssert(shortestPath!.trail[1].key == "F")
        XCTAssert(shortestPath!.trail[2].key == "C")
        XCTAssert(shortestPath!.trail[3].key == "B")
        XCTAssert(shortestPath!.total == 7)
    }
    
    func test9NodesPerformance1() {
        let nodes = TestUtilities.sample9Nodes()

        self.measure {
            let _ = GraphsAlgorithms.processDijkstra(source: nodes.first!, destination: nodes.last!)
        }
    }
    
    func test9NodesPerformance2() {
        let nodes = TestUtilities.sample9Nodes()

        self.measure {
            let _ = GraphsAlgorithms.processDijkstra2(source: nodes.first!, destination: nodes.last!)
        }
    }
}


class TestUtilities {
    static func sample9Nodes() -> [Vertex] {
        var nodes: [Vertex] = [Vertex(key: "A"), Vertex(key: "B"), Vertex(key: "C"), Vertex(key: "D"), Vertex(key: "E"), Vertex(key: "F"), Vertex(key: "G"), Vertex(key: "H"), Vertex(key: "I")]
        
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[1], weight: 3)
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[2], weight: 7)
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[3], weight: 5)
        
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes[2], weight: 1)
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes[4], weight: 7)
        
        GraphsAlgorithms.addEdge(source: nodes[2], neighbour: nodes[4], weight: 2)
        GraphsAlgorithms.addEdge(source: nodes[2], neighbour: nodes[5], weight: 1)
        GraphsAlgorithms.addEdge(source: nodes[2], neighbour: nodes[6], weight: 3)
        
        GraphsAlgorithms.addEdge(source: nodes[3], neighbour: nodes[2], weight: 3)
        GraphsAlgorithms.addEdge(source: nodes[3], neighbour: nodes[6], weight: 2)
        
        GraphsAlgorithms.addEdge(source: nodes[4], neighbour: nodes[5], weight: 2)
        GraphsAlgorithms.addEdge(source: nodes[4], neighbour: nodes[7], weight: 1)
        
        GraphsAlgorithms.addEdge(source: nodes[5], neighbour: nodes[7], weight: 3)
        GraphsAlgorithms.addEdge(source: nodes[5], neighbour: nodes[8], weight: 2)
        
        GraphsAlgorithms.addEdge(source: nodes[6], neighbour: nodes[5], weight: 3)
        GraphsAlgorithms.addEdge(source: nodes[6], neighbour: nodes[8], weight: 4)
        
        GraphsAlgorithms.addEdge(source: nodes[7], neighbour: nodes[8], weight: 5)
        
        return nodes
    }
    
    static func sample5Nodes() -> [Vertex] {
        var nodes: [Vertex] = [Vertex(key: "A"), Vertex(key: "B"), Vertex(key: "C"), Vertex(key: "D"), Vertex(key: "E")]
        
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[1], weight: 1)
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[3], weight: 4)
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes[3], weight: 5)
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes[2], weight: 2)
        GraphsAlgorithms.addEdge(source: nodes[3], neighbour: nodes.last!, weight: 8)
        
        return nodes
    }
    
    static func sample4Nodes() -> [Vertex] {
        var nodes: [Vertex] = [Vertex(key: "A"), Vertex(key: "B"), Vertex(key: "C"), Vertex(key: "D")]
        
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[1], weight: 1)
        GraphsAlgorithms.addEdge(source: nodes.first!, neighbour: nodes[2], weight: 2)
        GraphsAlgorithms.addEdge(source: nodes[1], neighbour: nodes.last!, weight: 10)
        GraphsAlgorithms.addEdge(source: nodes[2], neighbour: nodes.last!, weight: 5)
        
        return nodes
    }
}

//
//  ViewController.swift
//  Dijkstra
//
//  Created by Zafra, Guillermo (Consultant) on 10/04/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit


class Vertex {
    var neighbors = [Edge]()
    var key: String
    init(key: String) {
        self.key = key
    }
}

class Edge {
    var neighbour: Vertex!
    var weight: Int
    
    init() {
        weight = 0
    }
}

class Path {
    var total: Int!
    var destination: Vertex!
    var previous: Path!
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup
        let startingPoint = Vertex(key: "A")
        let node2 = Vertex(key: "B")
        let node3 = Vertex(key: "C")
        let finalNode = Vertex(key: "D")
        
        var _: [Vertex] = [startingPoint, node2, node3, finalNode]
        
        addEdge(source: startingPoint, neighbour: node2, weight: 1)
        addEdge(source: startingPoint, neighbour: node3, weight: 2)
        addEdge(source: node2, neighbour: finalNode, weight: 10)
        addEdge(source: node3, neighbour: finalNode, weight: 5)
        
        if let shortestPath = processDijkstra(source: startingPoint, destination: finalNode) {
            printPath(shortestPath)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addEdge(source: Vertex, neighbour: Vertex, weight: Int) {
        let newEdge = Edge()
        
        newEdge.neighbour = neighbour
        newEdge.weight = weight
        source.neighbors.append(newEdge)
    }
    
    func processDijkstra(source: Vertex, destination: Vertex) -> Path? {
        var pathsToEvaluate = [Path]()
        var finalPaths = [Path]()
        
        // Create frontier using source's edges
        for edge in source.neighbors {
            let newPath = Path()
            
            newPath.destination = edge.neighbour
            newPath.previous = nil
            newPath.total = edge.weight
            
            pathsToEvaluate.append(newPath)
        }
        
        
        var bestPath = Path()
        
        while pathsToEvaluate.count != 0 {
            
            // Get best path (shortest weight)
            bestPath = Path()
            var bestPathIndex = 0
            
            for idx in 0..<pathsToEvaluate.count {
                let itemPath = pathsToEvaluate[idx]
                
                if (bestPath.total == nil) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    bestPathIndex = idx
                }
            }
            
            
            //enumerate the bestPath edges
            
            for edge in bestPath.destination.neighbors {
                let newPath = Path()
                
                newPath.destination = edge.neighbour
                newPath.previous = bestPath
                newPath.total = bestPath.total + edge.weight
                
                pathsToEvaluate.append(newPath)
            }
            
            finalPaths.append(bestPath)
            
            pathsToEvaluate.remove(at: bestPathIndex)
            
        }
        
        
        return finalPaths.filter({ path in path.destination.key == destination.key }).sorted(by: { (path1, path2) -> Bool in
            return path1.total < path2.total
        }).first
    }
    
    func printPath(_ path: Path) {
        var currentPath: Path? = path
        while currentPath != nil {
            print(currentPath!.destination.key)
            currentPath = currentPath!.previous
        }
    }
    
}


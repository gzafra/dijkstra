//
//  GraphsAlgorithms.swift
//  Dijkstra
//
//  Created by Guillermo Zafra on 10/04/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

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
    
    var trail: [Vertex] {
        var visitedNodes = [Vertex]()
        var currentVertex: Path? = self
        while currentVertex != nil {
            visitedNodes.append(currentVertex!.destination)
            currentVertex = currentVertex!.previous
        }
        return visitedNodes
    }
}

class GraphsAlgorithms {
    static func addEdge(source: Vertex, neighbour: Vertex, weight: Int) {
        let newEdge = Edge()
        
        newEdge.neighbour = neighbour
        newEdge.weight = weight
        source.neighbors.append(newEdge)
    }
    
    static func processDijkstra(source: Vertex, destination: Vertex) -> Path? {
        var pathsToEvaluate = [Path]()
        var finalPaths = [Path]()
        
        // Create frontier using source's edges
        pathsToEvaluate.append(contentsOf: pathsForEdges(source.neighbors))
        
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
            pathsToEvaluate.append(contentsOf: pathsForEdges(bestPath.destination.neighbors, currentPath: bestPath))
            
            finalPaths.append(bestPath)
            
            pathsToEvaluate.remove(at: bestPathIndex)
        }
        
        
        let shortestPath = finalPaths.filter({ path in path.destination.key == destination.key }).sorted(by: { (path1, path2) -> Bool in
            return path1.total < path2.total
        }).first
        printPath(shortestPath)
        return shortestPath
    }
    
    static func pathsForEdges(_ edges: [Edge], currentPath: Path? = nil) -> [Path] {
        var paths = [Path]()
        for edge in edges {
            let newPath = Path()
            
            newPath.destination = edge.neighbour
            newPath.previous = currentPath
            newPath.total = (currentPath?.total ?? 0) + edge.weight
            
            paths.append(newPath)
        }
        return paths
    }
    
    static func printPath(_ path: Path?) {
        var currentPath: Path? = path
        while currentPath != nil {
            print(currentPath!.destination.key)
            currentPath = currentPath!.previous
        }
    }
}

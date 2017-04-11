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
    
    static func processDijkstra2(source: Vertex, destination: Vertex) -> Path? {
        var pathsToEvaluate = [Path]()
        var finalBestPath: Path? = nil
        
        // Create frontier using source's edges
        pathsToEvaluate.append(contentsOf: pathsForEdges(source.neighbors))
        
        var bestPath = Path()
        
        while pathsToEvaluate.count != 0 {
            
            // Sort by total (shortest first)
            pathsToEvaluate = pathsToEvaluate.sorted(by: { (path1, path2) -> Bool in
                return path1.total < path2.total
            })
            
            // Remove shortest path to evaluate
            bestPath = pathsToEvaluate.removeFirst()
            
            // Get new paths filtering out those already contained with higher or equal total
            let newPaths = pathsForEdges(bestPath.destination.neighbors, currentPath: bestPath).filter({ (path) -> Bool in
                return !pathsToEvaluate.contains(where: {path.destination.key == $0.destination.key && path.total >= $0.total })
            })
            
            // Filter out paths already in the list that are worst than we new ones
            pathsToEvaluate = pathsToEvaluate.filter({ (path) -> Bool in
                return !newPaths.contains(where: {path.destination.key == $0.destination.key && path.total > $0.total })
            })
            
            // Add new paths to evaluate
            pathsToEvaluate.append(contentsOf: newPaths)
            
            // If current bestPath leads to destination, add it as final
            if destination.key == bestPath.destination.key && (finalBestPath == nil || bestPath.total < finalBestPath!.total) {
                finalBestPath = bestPath
            }
        }

        printPath(finalBestPath)
        return finalBestPath
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

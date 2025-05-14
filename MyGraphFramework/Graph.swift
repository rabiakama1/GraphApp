import Foundation

public class Graph {
    private var nodes: [String: Node]
    
    public init() {
        self.nodes = [:]
    }
    
    public func addNode(_ node: Node) {
        nodes[node.id] = node
    }
    
    public func getNode(withId id: String) -> Node? {
        return nodes[id]
    }
    
    public func findClosestNode(ofType pointType: String, fromNodeId: String) -> (node: Node, distance: Double)? {
        guard let startNode = nodes[fromNodeId] else { return nil }
        
        var distances: [String: Double] = [:]
        var visited: Set<String> = []
        var queue: [(nodeId: String, distance: Double)] = [(fromNodeId, 0)]
        
        // Initialize distances
        for nodeId in nodes.keys {
            distances[nodeId] = Double.infinity
        }
        distances[fromNodeId] = 0
        
        while !queue.isEmpty {
            queue.sort { $0.distance < $1.distance }
            let (currentId, currentDistance) = queue.removeFirst()
            
            if visited.contains(currentId) { continue }
            visited.insert(currentId)
            
            guard let currentNode = nodes[currentId] else { continue }
            
            // If we found a node of the desired type, return it
            if currentNode.pointType == pointType && currentId != fromNodeId {
                return (currentNode, currentDistance)
            }
            
            // Process all edges
            for edge in currentNode.edges {
                let neighborId = edge.id
                let newDistance = currentDistance + edge.weight
                
                if newDistance < (distances[neighborId] ?? Double.infinity) {
                    distances[neighborId] = newDistance
                    queue.append((neighborId, newDistance))
                }
            }
        }
        
        return nil
    }
} 
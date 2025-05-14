import Foundation

public class MyGraphFramework {
    private let graph: Graph
    
    public init(graph: Graph) {
        self.graph = graph
    }
    
    public convenience init(jsonData: Data) throws {
        let graph = try GraphParser.parseGraph(from: jsonData)
        self.init(graph: graph)
    }
    
    public convenience init(jsonString: String) throws {
        let graph = try GraphParser.parseGraph(from: jsonString)
        self.init(graph: graph)
    }
    
    public func findClosestNode(ofType pointType: String, fromNodeId: String) -> (node: Node, distance: Double)? {
        return graph.findClosestNode(ofType: pointType, fromNodeId: fromNodeId)
    }
} 
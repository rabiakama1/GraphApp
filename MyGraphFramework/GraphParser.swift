import Foundation

public class GraphParser {
    public static func parseGraph(from jsonData: Data) throws -> Graph {
        let decoder = JSONDecoder()
        let node = try decoder.decode(Node.self, from: jsonData)
        
        let graph = Graph()
        graph.addNode(node)
        
        // Add connected nodes
        for edge in node.edges {
            let connectedNode = Node(
                id: edge.id,
                pointType: "point", // Default type for connected nodes
                edges: [Edge(id: node.id, weight: edge.weight)]
            )
            graph.addNode(connectedNode)
        }
        
        return graph
    }
    
    public static func parseGraph(from jsonString: String) throws -> Graph {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw GraphError.invalidJSONString
        }
        return try parseGraph(from: jsonData)
    }
}

public enum GraphError: Error {
    case invalidJSONString
} 
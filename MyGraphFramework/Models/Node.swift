import Foundation

public struct Node: Codable, Identifiable {
    public let id: String
    public let pointType: String
    public let edges: [Edge]
    
    public init(id: String, pointType: String, edges: [Edge]) {
        self.id = id
        self.pointType = pointType
        self.edges = edges
    }
} 
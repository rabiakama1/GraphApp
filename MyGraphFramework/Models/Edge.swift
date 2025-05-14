import Foundation

public struct Edge: Codable {
    public let id: String
    public let weight: Double
    
    public init(id: String, weight: Double) {
        self.id = id
        self.weight = weight
    }
} 
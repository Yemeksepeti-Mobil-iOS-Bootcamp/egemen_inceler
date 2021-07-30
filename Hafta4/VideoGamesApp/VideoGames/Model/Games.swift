import Foundation

struct Games: Decodable {
    let all: [Game]
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}

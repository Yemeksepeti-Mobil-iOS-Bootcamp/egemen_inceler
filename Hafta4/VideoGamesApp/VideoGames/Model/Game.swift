import Foundation


class Game: Decodable {
    let image: String
    let name: String
    let rating: Double
    let released: String
    let slug: String?
    
    init(image: String, name: String, rating: Double, released: String, slug: String) {
        self.image = image
        self.name = name
        self.rating = rating
        self.released = released
        self.slug = slug
    }
    
    enum CodingKeys: String, CodingKey {
        case image = "background_image"
        case name
        case rating
        case released
        case slug
    }
}

import Foundation


struct GameDetail: Decodable{
    let name: String
    let img: String
    let released: String
    let metacritic: Double
    let description: String
    let rating: Double
    let slug: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name_original"
        case img = "background_image"
        case released
        case metacritic
        case description
        case rating
        case slug
        
    }
}

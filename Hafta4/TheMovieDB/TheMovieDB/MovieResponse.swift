//
//  Movie.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 12.07.2021.
//

import Foundation

struct MovieResponse: Decodable{
    let title: String
    let poster_path: String
    var release_date: String{
        return _name ?? "Coming Soon"
    }
    var original_title: String
    let id: Int
    let vote_average: Double
    
    private var _name: String?
    
    enum CodingKeys: String, CodingKey{
        case title
        case poster_path
        case original_title
        case _name = "release_date"
        case id
        case vote_average
    }
}

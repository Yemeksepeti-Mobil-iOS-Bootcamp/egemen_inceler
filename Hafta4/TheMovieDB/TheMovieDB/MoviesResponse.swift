//
//  Movies.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 12.07.2021.
//

import Foundation

struct MoviesResponse: Decodable {
    let all: [MovieResponse]
    
    enum CodingKeys: String, CodingKey{
        case all = "results"
    }
}

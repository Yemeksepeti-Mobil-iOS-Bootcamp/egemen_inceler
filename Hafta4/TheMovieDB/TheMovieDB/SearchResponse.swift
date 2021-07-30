//
//  SearchResponse.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 14.07.2021.
//

import Foundation

struct SearchResponse: Decodable{
    let original_title: String
    let overview: String
    
    enum CodingKeys: String, CodingKey{
        case original_title
        case overview
    }
}

//
//  Movie.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 13.07.2021.
//

import Foundation

class Movie{
    var id: Int
    var imageURL: String
    var imageTitle: String
    var isFavoried: Bool
    
    init(id: Int, url: String, title: String, favori: Bool = false){
        self.id         = id
        self.imageURL   = url
        self.imageTitle = title
        self.isFavoried = favori
    }
}

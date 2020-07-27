//
//  MovieModel.swift
//  Romato
//
//  Created by Jithin M on 20/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation

struct Movie : Codable {
    var original_title : String
    var overview : String
    var release_date : String
    var genre_ids : [Int]
    var poster_path : String
    var original_language : String
    var vote_average : Double
    var vote_count : Double
    var adult : Bool
}

struct Response : Codable {
    
    var results : [Movie]
    
}

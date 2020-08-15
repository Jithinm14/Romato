//
//  MovieModel.swift
//  Romato
//
//  Created by Jithin M on 20/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation

struct Movie : Codable {
    let original_title : String?
    let overview : String?
    let release_date : String?
    let genre_ids : [Int]?
    let poster_path : String?
    let original_language : String?
    let vote_average : Double?
    let vote_count : Double?
    let adult : Bool?
}

struct Response : Codable {
    
    var results : [Movie]
    
}

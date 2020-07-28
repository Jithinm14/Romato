//
//  PosterImage.swift
//  Romato
//
//  Created by Jithin M on 27/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation

class PosterImage {
    
    var imageUrl : URL
    var isCached : Bool = false
    
    init(resourcePath: String) {
        self.imageUrl = URL(string: resourcePath)!
    }
    
}

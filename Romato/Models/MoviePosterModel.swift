//
//  MoviePosterModel.swift
//  Romato
//
//  Created by Jithin M on 23/08/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import SwiftUI

struct MoviePosterModel {
    let posterUrl : URL?
    let resourceName : String?
}

extension MoviePosterModel {
    var placeHolderImage : Image {
        return Image("placeholder")
    }
}

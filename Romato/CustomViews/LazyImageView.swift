//
//  LazyImageView.swift
//  Romato
//
//  Created by Jithin M on 22/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import SwiftUI

struct LazyImageView: View {
    
    @ObservedObject var moviePoster : MoviePosterViewModel
    
    init(imageModel: MoviePosterModel) {
        self.moviePoster = MoviePosterViewModel(movie: imageModel)
    }
    
    var body: some View {
        Group {
            if moviePoster.image != nil {
                Image(uiImage: moviePoster.image!)
            } else {
                RTActivityIndicator(animate: Binding<Bool>.constant(true))
            }
        }
    }
}

struct LazyImageView_Previews: PreviewProvider {
    static var previews: some View {
        LazyImageView(imageModel: MoviePosterModel(posterUrl: URL(string: "https://picsum.photos/200/300")!, resourceName: nil))
    }
}

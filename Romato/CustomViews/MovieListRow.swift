//
//  MovieListRow.swift
//  Romato
//
//  Created by Jithin M on 21/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import SwiftUI

struct MovieListRow: View {
    
    var movie : MovieViewModel
    
    init(movie: MovieViewModel) {
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            movie.posterImage.frame(width: 120, height: 160)
            VStack {
                Text(movie.movieName).font(.title).multilineTextAlignment(.leading)
                Spacer().frame(height: 10)
                Text(movie.releaseDate).font(.system(size: 14)).multilineTextAlignment(.leading)
                Spacer().frame(height: 10)
                HStack(alignment: .center){
                    Text(movie.language).font(.system(size: 14)).multilineTextAlignment(.leading)
                    Text(movie.rating).font(.system(size: 14)).multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

struct MovieListRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRow(movie: MovieViewModel(movie: Movie(original_title: "Catch Me If You Can", overview: "Notorious con artist Frank Abagnale has duped people worth millions of dollars with his masterful art of deception. With his scams getting bolder, he is soon pursued by FBI agent Carl Hanratty.", release_date: "25 December 2002", genre_ids: [12,222,14], poster_path: "", original_language: "English", vote_average: 8.2, vote_count: 96, adult: false))).previewLayout(.fixed(width: 300, height: 200))
    }
}

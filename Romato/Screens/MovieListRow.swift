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
            LazyImageView(imageModel: movie.posterResource).frame(width: 185, height: 278)
            VStack(alignment: .leading) {
                Text(movie.movieName).font(.title).multilineTextAlignment(.leading)
                Spacer().frame(height: 10)
                Text("(Biography, Crime, Drama)").font(.system(size: 13)).multilineTextAlignment(.leading)
                Spacer(minLength: 30)
                Button(action: {
                    self.markFavorite()
                }) {
                    HStack{
                        Image("favoriteTab")
                        Text("Add to Favorite")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(minHeight: 20, maxHeight: 30)
                    .background(Color.red)
                    .cornerRadius(28)
                }
                Spacer().frame(height: 10)
                VStack(alignment: .leading) {
                    Text(movie.language).font(.system(size: 13)).multilineTextAlignment(.leading)
                    Spacer().frame(height: 10)
                    Text(movie.rating).font(.system(size: 13)).multilineTextAlignment(.leading)
                    Spacer().frame(height: 10)
                    Text(movie.releaseDate).font(.system(size: 11)).multilineTextAlignment(.leading)
                }
            }
        }.environment(\.defaultMinListRowHeight, 278)
    }
    
    func markFavorite() {
        
    }
}

struct MovieListRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRow(movie: MovieViewModel(movie: Movie(original_title: "Catch Me If You Can", overview: "Notorious con artist Frank Abagnale has duped people worth millions of dollars with his masterful art of deception.", release_date: "25 December 2002", genre_ids: [12,222,14], poster_path: "", original_language: "en", vote_average: 8.2, vote_count: 96, adult: false))).previewLayout(.fixed(width: 300, height: 200))
    }
}

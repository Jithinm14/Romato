//
//  HomeView.swift
//  Romato
//
//  Created by Jithin M on 17/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var movieListModel = MovieListViewModel(category: .NowShowing)
    
    var body: some View {
        List(self.movieListModel.movies, id: \.id) { movie in
            MovieListRow(movie: movie)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

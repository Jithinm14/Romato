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
        NavigationView {
            List(self.movieListModel.movies, id: \.id) { movie in
                MovieListRow(movie: movie)
            }.navigationBarTitle("Now Playing")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

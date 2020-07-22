//
//  MovieListViewModel.swift
//  Romato
//
//  Created by Jithin M on 21/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import Combine

enum DataCategory {
    case NowShowing
    case Trending
    
    var service : WebService {
        switch self {
        case .NowShowing:
            return .NowPlaying
        case .Trending:
            return .Trending
        }
    }
    
}

class MovieListViewModel : ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    private var cancellable : AnyCancellable?
    
    init(category: DataCategory) {
        self.fetchMovies(category: category)
    }
    
    private func fetchMovies(category: DataCategory) {
        
        self.cancellable = NetworkService().fetchFromNetwork(service: category.service).map { (movieArray) -> [MovieViewModel]  in
            movieArray.map { (movie) -> MovieViewModel in
                return MovieViewModel(movie: movie)
            }
        }.sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                self.handleError(error: error as! NetworkError)
            case .finished:
                break
            }
        }) { (movieModelList) in
            self.movies = movieModelList
        }
    }
    
    //TODO:
    private func handleError(error: NetworkError) {
        
    }
    
}

struct MovieViewModel {
    
    init(movie: Movie) {
        
    }
    
}

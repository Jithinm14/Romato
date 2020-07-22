//
//  MovieListViewModel.swift
//  Romato
//
//  Created by Jithin M on 21/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

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
    
    private var movie : Movie?
    private let placeHolder = "Not available"
    
    var movieName : String {
        return movie?.original_title ?? placeHolder
    }
    
    var description : String {
        return movie?.overview ?? placeHolder
    }
    
    var genres : String {
        //TODO : Return comma seperated genres after mapping with genre codes.
        return placeHolder
    }
    
    var releaseDate : String {
        return movie?.release_date ?? placeHolder
    }
    
    var language : String {
        //TODO : Map language code to language strings
        return movie?.original_language ?? placeHolder
    }
    
    var rating : String {
        return String("\(movie?.vote_count)")
    }
    
    var isAdult : Bool {
        return movie?.adult ?? false
    }
    
    var posterImage : Image {
        Image("")
    }
    
    init(movie: Movie) {
        
    }
    
}

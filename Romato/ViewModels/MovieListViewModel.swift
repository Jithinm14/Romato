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

enum Language : String {
    case en
    case ko
    case fr
    case es
    
    var languageString : String {
        switch self {
        case .en:
            return "English"
        case .ko:
            return "Korean"
        case .fr:
            return "French"
        case .es:
            return "Spanish"
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

struct MovieViewModel : Identifiable {
    
    private var movie : Movie?
    private let placeHolder = "N/A"
    let id = UUID()
    
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
        let release = movie?.release_date ?? placeHolder
        return String("Release : \(release)")
    }
    
    var language : String {
        guard let language = movie?.original_language, let languageString = (Language(rawValue: language)?.languageString) else {
            return String("Language : \(placeHolder)")
        }
        return  String("Language : \(languageString)")
    }
    
    var rating : String {
        guard let rating = movie?.vote_average else {
            return "Rating : \(placeHolder)"
        }
        return "Rating : (\(rating)/10)"
    }
    
    var isAdult : Bool {
        return movie?.adult ?? false
    }
    
    var posterResource : MoviePosterModel {
        guard let posterResource = movie?.poster_path else {
            return MoviePosterModel(posterUrl: nil, resourceName: nil)
        }
        return MoviePosterModel(posterUrl: UrlUtility.posterUrlForResource(resourcePath: posterResource), resourceName: UrlUtility.fileNameFrom(resourcePath: posterResource))
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
}

struct MovieListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

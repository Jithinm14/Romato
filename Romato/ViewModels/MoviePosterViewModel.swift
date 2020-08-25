//
//  MoviePosterViewModel.swift
//  Romato
//
//  Created by Jithin M on 24/08/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MoviePosterViewModel: ObservableObject {
    
    @Published var image : UIImage?
    var cancellable : AnyCancellable?
    let posterModel : MoviePosterModel
    
    
    init(movie: MoviePosterModel) {
        self.posterModel = movie
        guard let posterUrl = movie.posterUrl, let resourceName = movie.resourceName else {
            self.image = UIImage(named: "placeholder")
            return
        }
        guard UrlUtility.doesFileExist(fileName: resourceName) else {
            load(imageFrom: posterUrl)
            return
        }
        guard let localPath = UrlUtility.downloadedPathFor(resource: resourceName) else {
            load(imageFrom: posterUrl)
            return
        }
        print("setting image from local path : \(localPath.path)")
        self.image = UIImage(contentsOfFile: localPath.path)
    }
    
    private func load(imageFrom url: URL) {
        self.cancellable = URLSession.shared.downloadTaskPublisher(for: url).map{
            
            guard let downLoadPath = UrlUtility.downloadedPathFor(resource: self.posterModel.resourceName) else {
                return UIImage(contentsOfFile: $0.url.path)
            }
            
            guard let _ = try? FileManager.default.moveItem(atPath: $0.url.path, toPath: downLoadPath.path) else {
                return UIImage(contentsOfFile: $0.url.path)
            }
            
            return UIImage(contentsOfFile: downLoadPath.path)
            }
        .replaceError(with: UIImage(named: "placeholder"))
        .receive(on: RunLoop.main)
        .assign(to: \.image, on: self)
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
    
}

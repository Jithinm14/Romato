//
//  UrlUtility.swift
//  Romato
//
//  Created by Jithin M on 20/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation

enum WebService {
    
    case NowPlaying
    case Trending
    
    var serviceName : String {
        switch self {
        case .NowPlaying:
            return "movie/now_playing"
        case .Trending:
            return "trending/movie/week"
        }
    }
    
    var queryParams : [(param : String,value : String)]? {
        switch self {
        case .NowPlaying:
            return [("language","en-US"),("page","1")]
        case .Trending:
            return nil
        }
    }
    
    
}

final class UrlUtility {
    
    static private let ApiKey : String = "0d037936b892833c34147638a28405ba"
    static private let baseUrl : String = "https://api.themoviedb.org/3/"
    static private let basePosterUrl : String = "http://image.tmdb.org/t/p/w185"
    
    static func posterUrlForResource(resourcePath: String) -> URL {
        guard let posterUrl = URL(string: (basePosterUrl + resourcePath)) else {
            //TODO: Handle later.
            return URL(string: "")!
        }
        return posterUrl
    }
    
    static func urlForService(service: WebService) -> URL {
        let completeUrl = addQueryParameters(url: (baseUrl + service.serviceName), params: service.queryParams)
        guard let url = URL(string: completeUrl) else {
            //TODO: Handle properly later.
            return URL(string: "")!
        }
        return url
    }
    
    static func downloadedPathFor(resource: String?) -> URL? {
        guard let resource = resource else {
            return nil
        }
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheDir.appendingPathComponent(resource)
    }
    
    static func doesFileExist(fileName: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func fileNameFrom(resourcePath: String) -> String {
        let components = resourcePath.components(separatedBy: "/")
        guard let fileName = components.last else {
        return (UUID().uuidString)
        }
        return fileName
    }
    
    private static func addQueryParameters(url: String, params: [(String,String)]?) -> String {
        var completeUrl = addApiKeyAsQueryParameter(url: url)
        guard let parameters = params else {
            return completeUrl
        }
        for parameter in parameters {
            let query = parameter.0 + "=" + parameter.1
            completeUrl += "&"
            completeUrl += query
        }
        return completeUrl
    }
    
    private static func addApiKeyAsQueryParameter(url: String) -> String {
        let apiKey = "api_key=\(ApiKey)"
        return url + "?" + apiKey
    }
    
}





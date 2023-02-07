//
//  APICaller.swift
//  NetflixClone
//
//  Created by Lina on 17/11/22.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
    case badUrl
}

enum UrlCategory {
    case trendingMovie
    case trendingTvs
    case upcomingMovies
    case popular
    case topratedMovies
    case discoverMovies
    case search
    case movie
    
    
    func getURL(with query: String?) -> URL? {
        
        let safeQuery = query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        var urlComponents = URLComponents()
        urlComponents.host = "api.themoviedb.org"
        urlComponents.scheme = "https"
        
        switch self {
        case .trendingMovie:
            urlComponents.path = "/3/trending/movie/day"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY)
            ]
        case .trendingTvs:
            urlComponents.path = "/3/trending/tv/day"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY)
            ]
        case .upcomingMovies:
            urlComponents.path = "/3/movie/upcoming"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .popular:
            urlComponents.path = "/3/movie/popular"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .topratedMovies:
            urlComponents.path = "/3/movie/top_rated"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .discoverMovies:
            urlComponents.path = "/3/discover/movie"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "with_watch_monetization_types", value: "flatrate")
            ]
        case .search:
            urlComponents.path = "/3/search/movie"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: K.API_KEY),
                URLQueryItem(name: "query", value: safeQuery)
            ]
        case .movie:
            urlComponents.host = "youtube.googleapis.com"
            urlComponents.path = "/youtube/v3/search"
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: safeQuery),
                URLQueryItem(name: "key", value: K.YoutubeAPI_KEY)
            ]
        }
        
        return urlComponents.url
    }
}

class APICaller {
    static let shared = APICaller()
    
    func makeRequest<T: Decodable>(type: T.Type, category url: UrlCategory, query: String?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url.getURL(with: query) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(type, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(K.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(K.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string:"\(Constants.baseURL)/3/movie/upcoming?api_key=\(K.API_KEY)&language=en-US&page=1") else { return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(K.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(K.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(K.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(K.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(K.YoutubeAPI_KEY)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                //print(results)
            }
            catch {
                completion(.failure(error))
                //print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

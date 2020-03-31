//
//  APIService.swift
//  AppStoreClone
//
//  Created by Jacobo Hernandez on 3/24/20.
//  Copyright © 2020 Jacobo Hernandez. All rights reserved.
//

import Foundation

class APIService {
    static let shared = APIService() // Singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil)
                return
            }
            
//            print(String(data: data!, encoding: .utf8))
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
//                print(searchResult)
//                searchResult.results.forEach({ print($0.primaryGenreName, $0.trackName) })
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
        }.resume()
    }
    
    func fetchNewGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchFreeGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
//                print(appGroup.feed.results)
//                appGroup.feed.results.forEach{( print($0.name) )}
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            do {
                let socialApp = try JSONDecoder().decode([SocialApp].self, from: data)
//                print(appGroup.feed.results)
                completion(socialApp, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
                
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            do {
                let socialApp = try JSONDecoder().decode(T.self, from: data)
//                print(appGroup.feed.results)
                completion(socialApp, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
}

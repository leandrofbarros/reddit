//
//  DataManager.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation
import ObjectMapper

enum DataManagerError: Error {
    
    case unknown
    case failedRequest
    case invalidResponse
    
}

final class DataManager {
    
    typealias RedditDataCompletion = (RedditData?, DataManagerError?) -> ()
    
    // MARK: - Properties
    
    private let baseURL: URL
    
    // MARK: - Initialization
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: - Requesting Data
    
    func redditData(completion: @escaping RedditDataCompletion) {
        
        let URL = baseURL.appendingPathComponent("r/swift/.json")
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFetchRedditData(data: data, response: response, error: error, completion: completion)
            }
            }.resume()
    }
    
    // MARK: - Helper Methods
    
    private func didFetchRedditData(data: Data?, response: URLResponse?, error: Error?, completion: RedditDataCompletion) {
        if let _ = error {
            completion(nil, .failedRequest)
            
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let jsonDecoder = JSONDecoder()
                    let redditData = try jsonDecoder.decode(RedditData.self, from: data)
                    completion(redditData, nil)
                    
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
}

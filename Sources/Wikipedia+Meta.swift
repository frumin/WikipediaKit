//
//  Wikipedia+Meta.swift
//  WikipediaKit
//
//  Created by Tom Zaworowski on 10/13/18.
//  Copyright © 2018 Frank Rausch. All rights reserved.
//

import Foundation

extension Wikipedia {
    
    public func requestWikiMeta(completion: @escaping (WikipediaMetadata?, WikipediaError?) -> ()) -> URLSessionDataTask? {
        
        let parameters: [String: String] = [
            "action": "query",
            "format": "json",
            "formatversion": "2",
            "meta": "siteinfo"
        ]
        
        guard let request = Wikipedia.buildURLRequest(language: WikipediaLanguage.systemLanguage, parameters: parameters) else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
            return nil
        }
        
        return WikipediaNetworking.shared.loadJSON(urlRequest: request, completion: { (jsonDictionary, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion (nil, error)
                }
                return
            }
            
            guard let jsonDictionary = jsonDictionary  else {
                DispatchQueue.main.async {
                    completion (nil, .decodingError)
                }
                return
            }
            
            let meta = WikipediaMetadata(jsonDictionary: jsonDictionary)
            DispatchQueue.main.async {
                completion(meta, error)
            }
        })
    }
}

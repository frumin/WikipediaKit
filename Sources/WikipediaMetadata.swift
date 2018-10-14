//
//  WikipediaMetadata.swift
//  WikipediaKit
//
//  Created by Tom Zaworowski on 10/13/18.
//  Copyright © 2018 Frank Rausch. All rights reserved.
//

import Foundation

public class WikipediaMetadata {
    
    public let mainPage: String
    public let name: String
    
    init(mainPage: String, name: String) {
        self.mainPage = mainPage
        self.name = name
    }
    
}

extension WikipediaMetadata {
    
    convenience init?(jsonDictionary dict: JSONDictionary) {
        guard let query = dict["query"] as? JSONDictionary,
            let general = query["general"] as? JSONDictionary,
            let mainPage = general["mainpage"] as? String,
            let name = general["sitename"] as? String
            else { return nil }
        
        
        self.init(mainPage: mainPage, name: name)
    }
    
}

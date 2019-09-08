//
//  Configuration.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation

struct API {

    static let BaseURL = URL(string: "https://www.reddit.com/")!

    static var AuthenticatedBaseURL: URL {
        return BaseURL
    }
    
}

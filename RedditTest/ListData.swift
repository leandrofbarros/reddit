//
//  ListData.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation
struct ListData : Codable {
    
    let children : [Children]?
    
    enum CodingKeys: String, CodingKey {
        case children = "children"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        children = try values.decodeIfPresent([Children].self, forKey: .children)
    }
    
}

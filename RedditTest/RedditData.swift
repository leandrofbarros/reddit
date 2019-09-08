//
//  RedditData.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation
struct RedditData : Codable {
    let listData : ListData?
    
    enum CodingKeys: String, CodingKey {
        case listData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        listData = try values.decodeIfPresent(ListData.self, forKey: .listData)
    }
    
}

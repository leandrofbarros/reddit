//
//  Children.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation
struct Children : Codable {
    let dataChildren : DataChildren?
    
    enum CodingKeys: String, CodingKey {
        case dataChildren = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataChildren = try values.decodeIfPresent(DataChildren.self, forKey: .dataChildren)
    }
    
}

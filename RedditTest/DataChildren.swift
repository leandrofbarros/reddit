//
//  DataChildren.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import Foundation
struct DataChildren : Codable {
    
    let title : String?
    let selftext : String?
    var thumbnail : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case selftext = "selftext"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        selftext = try values.decodeIfPresent(String.self, forKey: .selftext)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        if (!checkIsImage(thumbnail!)) {
            thumbnail = ""
        }
    }
    
    func checkIsImage(_ image: String) -> Bool {
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: image, options: [], range: NSRange(location: 0, length: image.utf16.count))
        
        for match in matches {
            guard let _ = Range(match.range, in: image) else { continue }
            return true
        }
        return false
    }
}

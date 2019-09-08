//
//  HomeViewModel.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import UIKit

struct HomeViewModel {
    
    // MARK: - Properties
    
    let children: [Children]
    
    // MARK: -
    
    var numberOfChildren: Int {
        return children.count
    }
    
}

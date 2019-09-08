//
//  DetailViewController.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: -- Outlets
    
    @IBOutlet weak var navigationView: UINavigationItem!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var titleReddit = ""
    var descriptionReddit = ""
    var imageURL = ""
    
    // MARK: - Lifecycle Methods
    
    /// View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.title = titleReddit
        descriptionView.text = descriptionReddit

        self.image.isHidden = true
        if (!imageURL.isEmpty) {
            image.downloaded(from: imageURL)
            self.image.isHidden = false
        }
        
    }
    
}


//
//  HomeTableViewCell.swift
//  RedditTest
//
//  Created by Leandro Falbo Barros on 2019-09-06.
//  Copyright © 2019 Leandro Falbo Barros. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func homeCellInit(_ image: String, title: String) {
        
        self.logoImage.isHidden = true
        if (!image.isEmpty) {
            self.logoImage.downloaded(from: image)
            self.logoImage.isHidden = false
        }
        
        self.titleLabel.text = title
    }
    
}

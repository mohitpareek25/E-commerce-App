//
//  PeopleWhoLikedCollectionViewCell.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 12/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit

class PeopleWhoLikedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageOutlet.layer.cornerRadius = 5
        imageOutlet.clipsToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        imageOutlet.layer.cornerRadius = imageOutlet.frame.height/2
    }
}

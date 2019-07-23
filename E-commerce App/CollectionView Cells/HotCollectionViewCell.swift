//
//  HotCollectionViewCell.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 12/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit

class HotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blurImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    //variables
//    var blurImageView = UIImage()
//    var itemImageView = UIImage()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        blurImage.image = blurImageView
//        itemImage.image = itemImageView
    }

}

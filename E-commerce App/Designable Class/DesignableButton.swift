//
//  DesignableButton.swift
//  stack1
//
//  Created by Anmol Kumar on 06/06/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    
    
    //MARK:- Border properties
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var ImageCornerRadius : CGFloat = 0{
        didSet{
            self.imageView?.layer.cornerRadius = ImageCornerRadius
        }
    }
    
    
    
    //MARK:- Shadow Properties
    @IBInspectable var shadowColor: UIColor = .clear{
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0{
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var shadowOpacity: Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }

}

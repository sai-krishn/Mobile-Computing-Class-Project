//
//  extensions.swift
//  IMDB Assignment
//
//  Created by sai krishna reddy avuthu on 11/19/20.
//

import UIKit

@IBDesignable
class CustomView: UIView{

    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

}

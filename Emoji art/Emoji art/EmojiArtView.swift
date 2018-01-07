//
//  EmojiArtView.swift
//  Emoji art
//
//  Created by Siddique on 02/01/18.
//  Copyright © 2018 Siddique. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {
    
    var backgroundImage: UIImage?{
        didSet{
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        backgroundImage?.draw(in: bounds)
    }
    

}

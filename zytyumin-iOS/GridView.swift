//
//  GridView.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/10/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

private let margin: CGFloat = 8
private let labelHeight: CGFloat = 16

class GridView: UIView {
    
    var text: String!
    var image: UIImage!
    var clickCallBack: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GridView.click(_:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let imageView = UIImageView(frame: CGRectMake(margin, margin, rect.width - 2 * margin, rect.height - 3 * margin - 16 ))
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.whiteColor()
        self.addSubview(imageView)
        
        let label = UILabel(frame: CGRectMake(margin, imageView.frame.maxY + margin, rect.width - 2 * margin, labelHeight))
        label.text = text
        label.font = UIFont(name: textFontName, size: 13.0)
        label.textColor = UIColor.textColor()
        label.textAlignment = .Center
        self.addSubview(label)
        
    }
    
    func click(sender: UITapGestureRecognizer) {
        if clickCallBack != nil {
            clickCallBack!()
        }
    }
}
//
//  PageCell.swift
//  Manchester United Indonesia
//
//  Created by NDS on 27/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //Membuat UIImageView
    let pageImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.rgb(red: 168, green: 0, blue: 56)
        
        print("width: \(frame.width) & h: \(frame.height)")
        addSubview(pageImageView)
        
        _ = pageImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 350)

    }
    
}

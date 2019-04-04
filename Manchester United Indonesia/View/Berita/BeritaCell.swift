//
//  BeritaCVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 05/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class BeritaCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    var berita: Berita? {
        didSet {
            if let description = berita?.description {
                contentTextView.text = description
            }
            guard let image = berita?.gambar.resizeImage(frame.width, opaque: false, contentMode: UIView.ContentMode.scaleAspectFit) else {
                fatalError()
            }
            beritaImageview.image = image
//            print("width: \(image.size.width) & height: \(image.size.height)")
        }
    
    }
    
    let beritaImageview: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.init(name: "HelveticaNeue", size: 13)
        tv.backgroundColor = UIColor.clear
        tv.isEditable = false
        return tv
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "like")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "comment")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)

        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "share")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)

        return button
    }()
    
    var beritaImageNSLayout: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        //Set warna background cell
        backgroundColor = .white
        
        //Menampilkan component pada cell
        addSubview(beritaImageview)
        addSubview(contentTextView)
        
        //Membuat UIImage menjadi gradient
//        beritaImageview.image = imageWithGradient(img: UIImage(named: "naruto"))
        
        
        //MARK: Autolayout berita cell
        _ = beritaImageview.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = contentTextView.anchor(beritaImageview.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupBottomButton()
        
    }
    
    fileprivate func setupBottomButton() {
        
        let likeButtonContainer = UIView()
//        likeButtonContainer.backgroundColor = UIColor.yellow
        
        let commentButtonContainer = UIView()
//        commentButtonContainer.backgroundColor = UIColor.red
        
        let shareButtonContainer = UIView()
//        shareButtonContainer.backgroundColor = UIColor.blue
        
        let buttonStackView = UIStackView(arrangedSubviews: [likeButtonContainer, commentButtonContainer, shareButtonContainer])
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        
        _ = buttonStackView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        likeButton.addTopBorder(UIColor.lightGray, height: 0.5)
        likeButton.addRightBorder(UIColor.lightGray, width: 0.5)
        commentButton.addTopBorder(UIColor.lightGray, height: 0.5)
        commentButton.addRightBorder(UIColor.lightGray, width: 0.5)
        shareButton.addTopBorder(UIColor.lightGray, height: 0.5)
        
        _ = likeButton.anchor(likeButtonContainer.topAnchor, left: likeButtonContainer.leftAnchor, bottom: likeButtonContainer.bottomAnchor, right: likeButtonContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        likeButton.centerXAnchor.constraint(equalTo: likeButtonContainer.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: likeButtonContainer.centerYAnchor).isActive = true
        
        _ = commentButton.anchor(commentButtonContainer.topAnchor, left: commentButtonContainer.leftAnchor, bottom: commentButtonContainer.bottomAnchor, right: commentButtonContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        commentButton.centerXAnchor.constraint(equalTo: commentButtonContainer.centerXAnchor).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: commentButtonContainer.centerYAnchor).isActive = true
        
        _ = shareButton.anchor(shareButtonContainer.topAnchor, left: shareButtonContainer.leftAnchor, bottom: shareButtonContainer.bottomAnchor, right: shareButtonContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        shareButton.centerXAnchor.constraint(equalTo: shareButtonContainer.centerXAnchor).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: shareButtonContainer.centerYAnchor).isActive = true
    
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    //MARK: Fungsi membuat gradient pada UIImage
    func imageWithGradient(img: UIImage!) -> UIImage {
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [1.0, 0.0]
        
        //Location untuk horizontal gradient [x , y]
//        let locations: [CGFloat] = [0.0, 1.0]
        
        let bottomColor = UIColor.clear.cgColor
        let topColor = UIColor.gray.cgColor
        let colors = [topColor, bottomColor] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations )
        
        let startPoint = CGPoint(x: img.size.width / 2, y: 10)
        let endPoint = CGPoint(x: img.size.width / 2, y: img.size.height + 30)
        
        //Horizontal Gradient
//        let startPoint = CGPoint(x: 0, y: img.size.height / 2)
//        let endPoint = CGPoint(x: 50, y: img.size.height / 2)
        
//        print("width \(img.size.width) & height \(img.size.height)")
        
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
   
}

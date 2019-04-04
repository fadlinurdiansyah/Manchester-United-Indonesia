//
//  FacilityCell.swift
//  Manchester United Indonesia
//
//  Created by NDS on 02/04/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class FacilityCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    /*------------UI Component--------------*/
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fasilitas"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("^", for: UIControl.State.normal)
        return button
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        return view
    }()
    
    let fasilitasTextView: UITextView = {
        let tv = UITextView()
        tv.text = """
                • Welcome Drink
                • Snack
                • Door Prize
                • Kuis Menarik
                • Live Musik
                """
        tv.font = UIFont.init(name: "HelveticaNeue", size: 12)
        tv.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    /*---------Declaration Variable-----------------*/
    var indexPath: IndexPath!
    weak var delegate: expandedCellDelegate?
    
    
    /*---------Load Component-----------------*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(titleLabel)
        addSubview(lineView)
        addSubview(fasilitasTextView)
        addSubview(expandButton)
        
        
        _ = titleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = expandButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 50, heightConstant: 50)
        
        _ = lineView.anchor(expandButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        _ = fasilitasTextView.anchor(lineView.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        expandButton.addTarget(self, action: #selector(expand), for: UIControl.Event.touchUpInside)
        
        setupView(hidden: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    
    /* --------------------------- Manual Function ------------------------------*/
    
    @objc func expand() {
        if let delegate = self.delegate {
            delegate.topButtonTouched(indexPath: indexPath)
        }
    }
    
    func setupView(hidden: Bool) {
        
        if hidden == true {
            
            expandButton.transform = CGAffineTransform(rotationAngle: .pi)
            
        } else {
            
            expandButton.transform = CGAffineTransform.identity
        }
        
        self.fasilitasTextView.isHidden = hidden
        
    }
    
    
}

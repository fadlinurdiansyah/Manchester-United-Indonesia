//
//  NobarMB.swift
//  Manchester United Indonesia
//
//  Created by NDS on 17/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class NobarMB: UIView, UISearchBarDelegate {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    /*------------UI Component--------------*/
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Cari Lokasi Nobar Di Dekatmu"
        sb.searchBarStyle = .prominent
        sb.sizeToFit()
        sb.backgroundImage = UIImage()
        sb.isTranslucent = false
        sb.layer.cornerRadius = 10
        sb.layer.borderWidth = 1
        sb.layer.borderColor = UIColor.rgb(red: 233, green: 235, blue: 238).cgColor
        sb.layer.masksToBounds = true
        return sb
    }()
    
     /*---------Declaration Variable-----------------*/
    
    var nobarVC: NobarVC?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white //UIColor.rgb(red: 233, green: 235, blue: 238)
        
        addSubview(searchBar)
        
        
        //Merubah font dan size placeholder UISearchBar
        let searchPlaceholderText = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchPlaceholderText.font = UIFont(name: "HelveticaNeue", size: 11)
        
        //Merubah font dan size text input UISearchBar
        let searchInputText = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchInputText.font = UIFont(name: "HelveticaNeue", size: 11)
        
        
        //MARK: Autolayout NobarMB
        _ = searchBar.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 30)
        
        searchBar.delegate = self //Membuat delegasi UISearchbar terhadap NobarMB
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Method: Ketika UISearchbar di input text akan memanggil method filterNobarContent yang ada di NobarVC
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchText = searchBar.text else {
            fatalError()
        }

        nobarVC?.filterNobarContent(text: searchText)
    
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
}

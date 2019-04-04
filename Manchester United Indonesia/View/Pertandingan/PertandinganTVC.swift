//
//  PertandinganTVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 01/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class PertandinganTVC: UITableViewCell {
 
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //Label team tuan rumah
    let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Man Utd"
        label.textColor = UIColor.gray
//        label.font = UIFont.systemFont(ofSize: 14)
        label.font = UIFont.init(name: "Helvetica Neue", size: 14)
        label.textAlignment = .right
        return label
    }()
    
    //Label waktu pertandingan
    let waktuTandingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "22:00"
//        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.rgb(red: 54, green: 55, blue: 56)
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    //Label team lawan
    let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Southampton"
        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 14)
        label.font = UIFont.init(name: "Helvetica Neue", size: 14)
        return label
    }()
    
    //Label stadion
    var stadionLabel: UILabel = {
        let label = UILabel()
        label.text = "Old Traford"
//        label.font = UIFont.italicSystemFont(ofSize: 11)
        label.font = UIFont.init(name: "Helvetica Neue", size: 11)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    //Label pencetak gol team tuan rumah
    var goalHome: UILabel = {
        let label = UILabel()
        label.text = "Pogba (64, 81)"
//        label.font = UIFont.systemFont(ofSize: 11)
        label.font = UIFont.init(name: "Helvetica Neue", size: 11)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    //Label pencetak gol team lawan
    var goalAway: UILabel = {
        let label = UILabel()
        label.text = "(10) Benteke"
//        label.font = UIFont.systemFont(ofSize: 11)
        label.font = UIFont.init(name: "Helvetica Neue", size: 11)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
 
    //Label gambar bola goal tuan rumah
    var bolaLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10)  )
        label.font = UIFont(name: "FontAwesome", size: 10)
        let myChar: UniChar = 0xf1e3
        label.text = String(format: "%C", myChar)
//        label.setFontAwesome(unicode: "f2cc", color: UIColor.black)
        return label
    }()
    
    //Label gambar bola team lawan
    var bolaLabel2: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10)  )
        label.font = UIFont(name: "FontAwesome", size: 10)
        let myChar: UniChar = 0xf1e3
        label.text = String(format: "%C", myChar)
        //        label.setFontAwesome(unicode: "f2cc", color: UIColor.black)
        return label
    }()
    
    
    lazy var showButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("^", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleShow), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    /*
     -----------------------------------------------------
     First Load
     -----------------------------------------------------
     */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        showItem(hidden: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    //MARK: Fungsi menampilkan component table
    func setupViews() {
        addSubview(homeTeamLabel)
        addSubview(waktuTandingLabel)
        addSubview(awayTeamLabel)
        addSubview(stadionLabel)
        addSubview(goalHome)
        addSubview(goalAway)
        addSubview(bolaLabel)
        addSubview(bolaLabel2)
        addSubview(showButton)

        
        // Auto layout
        
        waktuTandingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _ = waktuTandingLabel.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 30)
        
        _ = homeTeamLabel.anchor(topAnchor, left: nil, bottom: nil, right: waktuTandingLabel.leftAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 200, heightConstant: 30)
        
        
        _ = awayTeamLabel.anchor(topAnchor, left: waktuTandingLabel.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 30)
        
        
        _ = stadionLabel.anchor(waktuTandingLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 10)
        stadionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = goalHome.anchor(waktuTandingLabel.bottomAnchor, left: nil, bottom: nil, right: centerXAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 10)
        
        _ = goalAway.anchor(waktuTandingLabel.bottomAnchor, left: centerXAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 12)

        
        _ = bolaLabel.anchor(goalHome.topAnchor, left: nil, bottom: nil, right: goalHome.leftAnchor, topConstant: 2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = bolaLabel2.anchor(goalAway.topAnchor, left: goalAway.rightAnchor, bottom: nil, right: nil, topConstant: 2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = showButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 50, heightConstant: 20)
    }
    
    @objc func handleShow() {
    }
    
    func showItem(hidden: Bool) {
        stadionLabel.isHidden = hidden
        goalHome.isHidden = hidden
        goalAway.isHidden = hidden
        bolaLabel.isHidden = hidden
        bolaLabel2.isHidden = hidden
    }
    
    

}


class PertandinganHeader: UITableViewHeaderFooterView {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //Label informasi pada section table / header table
    let headerInformasiLabel: UILabel = {
        let label = UILabel()
        label.text = "Jum 03 Mar 19 | Premier League"
        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 13)
        label.font = UIFont.init(name: "Helvetica Neue", size: 13)
        return label
    }()
    
    //Tombol table klasemen
    let klasemenButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Table", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
//        button.layer.masksToBounds = true
        return button
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    func setupViews() {
        
        addSubview(headerInformasiLabel)
        addSubview(klasemenButton)
        
        
        //Auto Layout
        
        _ = headerInformasiLabel.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 300, heightConstant: 20)
        headerInformasiLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        _ = klasemenButton.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 50, heightConstant: 20)
        klasemenButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
    }
}

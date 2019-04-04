//
//  NobarCell.swift
//  Manchester United Indonesia
//
//  Created by NDS on 17/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class NobarCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    var nobar: Nobar? {
        didSet {
            if  let idNobar = nobar?.idNobar,
                let lokasiNobar = nobar?.lokasiNobar,
                let homeTeam = nobar?.homeTeam,
                let awayTeam = nobar?.awayTeam,
                let jamKO = nobar?.jamKO,
                let tanggalKO = nobar?.tanggalKO,
                let jenisLokasi = nobar?.jenisLokasi,
                let kecamatan = nobar?.kecamatan,
                let kota = nobar?.kota,
                let htm = nobar?.htm,
                let fotoNobar = nobar?.fotoNobar {
                
                nameLokasiNobarLabel.text = lokasiNobar
                nobarImageView.image = UIImage(named: fotoNobar)
                matchLabel.text = "\(homeTeam) vs \(awayTeam) | \(jamKO)"
                jenisLokasiLabel.text = "\(jenisLokasi)"
                alamatNobarLabel.text = "\(kecamatan), \(kota)"
                tiketLabel.text = "HTM: \(hargaTiket(amount: htm))"
                tanggalLabel.text = convDate(dateString: tanggalKO)
                    
            }
            
        }
    }
    
    
    /*------------UI Component--------------*/
    
    let nobarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .red
        iv.image = UIImage(named: "nobar2")
//        iv.layer.cornerRadius = 10
//        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let matchLabel: UILabel = {
        let label = UILabel()
        label.text = "MUN vs ARS | 23.30 WIB"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        return label
    }()
    
    let nameLokasiNobarLabel: UILabel = {
        let label = UILabel()
        label.text = "Manchester United Cafe"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        label.numberOfLines = 0
        return label
    }()
    
    let jenisLokasiLabel: UILabel = {
        let label = UILabel()
        label.text = "Cafe"
        label.textColor = UIColor.rgb(red: 253, green: 0, blue: 84)
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.rgb(red: 253, green: 0, blue: 84).cgColor
        label.layer.borderWidth = 0.5
        return label
    }()
    
    let lokasiImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "location")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let alamatNobarLabel: UILabel = {
        let label = UILabel()
        label.text = "Cibitung, Bekasi Kab."
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 10)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        label.textAlignment = .left
        return label
    }()
    
    let tiketLabel: UILabel = {
        let label = UILabel()
        label.text = "HTM : Free"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
        label.textColor = UIColor.rgb(red: 253, green: 0, blue: 84)
        return label
    }()
    
    let tanggalLabel: UILabel = {
        let label = UILabel()
        label.text = "03 APR"
        label.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        label.font = UIFont.init(name: "Optima-Bold", size: 12)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        //-------Corner per-sudut-----------
        //layerMaxXMinYCorner = Kanan atas
        //layerMinXMaxYCorner = Kiri Bawah
        //layerMaxXMaxYCorner = Kanan Bawah
        //layerMinXMinYCorner = Kiri atas
        label.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            label.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        return label
    }()
    
    
    /*---------Declaration Variable-----------------*/
    
    var nobarVC: NobarVC?
    
    override func setupViews() {
        super.setupViews()
        
        
        //Set warna background collectionview cell
        backgroundColor = .white
        
        //MARK: UIComponent
        addSubview(nobarImageView)
        addSubview(matchLabel)
        addSubview(nameLokasiNobarLabel)
        addSubview(jenisLokasiLabel)
        addSubview(lokasiImage)
        addSubview(alamatNobarLabel)
        addSubview(tiketLabel)
        addSubview(tanggalLabel)
        
        //MARK: Autolayout Component Nobar Cell
        _ = nobarImageView.anchor(topAnchor, left: leftAnchor
            , bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        _ = matchLabel.anchor(topAnchor, left: nobarImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = nameLokasiNobarLabel.anchor(matchLabel.bottomAnchor, left: nobarImageView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = jenisLokasiLabel.anchor(nameLokasiNobarLabel.bottomAnchor, left: nameLokasiNobarLabel.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 20)
        
        _ = lokasiImage.anchor(jenisLokasiLabel.bottomAnchor, left: nameLokasiNobarLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 12, heightConstant: 12)
        
        _ = alamatNobarLabel.anchor(jenisLokasiLabel.bottomAnchor, left: lokasiImage.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 2, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = tiketLabel.anchor(alamatNobarLabel.bottomAnchor, left: matchLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = tanggalLabel.anchor(nil, left: nil, bottom: nobarImageView.bottomAnchor, right: nobarImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
    }
    
    
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    //MARK: Method convert number/double manjadi mata uang dengan pemisah
    func hargaTiket(amount: Double) -> String {
        
        //Jika nilai 0 maka di ubah menjadi text Free
        if amount == 0 {
            return "Free"
        } else {
            //Jika nilai tidak 0 maka nilai di convert menjadi format mata uang indonesia
            let currencyFormatter = NumberFormatter() //merubah NSNumberFormatter menjadi variable currencyFormatter
            currencyFormatter.usesGroupingSeparator = true //set pemisah ribuan,ratusan... pada nilai
            currencyFormatter.numberStyle = .currency //set nilai menjadi format mata uang
            currencyFormatter.locale = Locale(identifier: "id_ID") //set format mata uang menggunakan negara indonesia
            
            let priceString = currencyFormatter.string(from: NSNumber(value: amount))! //convert format NSNumber manjadi String
            return priceString
        }
    }
    
    //MARK: Method convert tanggal menjadi format hari,tanggal,bulan
    func convDate(dateString: String) -> String {
        let dateFormatter = DateFormatter() //merubah DataFormatter menjadi variable dateFormatter
        dateFormatter.dateFormat = "yyy-MM-dd" //Set formate date
        let newFormat = DateFormatter() //
        newFormat.calendar = Calendar(identifier: .iso8601)
        newFormat.locale = Locale(identifier: "id_ID")
        newFormat.timeZone = .current
        newFormat.dateFormat = "EEE dd MMM"
        if let date = dateFormatter.date(from: dateString) {
            return newFormat.string(from: date)
        } else {
            return ""
        }
    }

}



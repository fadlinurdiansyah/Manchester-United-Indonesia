//
//  File.swift
//  Manchester United Indonesia
//
//  Created by NDS on 09/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class BeritaHeader: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    let headerImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.red
        return iv
    }()
    
    let headerViewBottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 75, green: 76, blue: 82)
        return view
    }()
    
    let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "23:30"
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 11)
        label.textAlignment = .center
        return label
    }()
    
    let kompetisiLabel: UILabel = {
        let label = UILabel()
        label.text = "English Premier League"
        label.font = UIFont.init(name: "HelveticaNeue", size: 11)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let jamKOLabel: UILabel = {
        let label = UILabel()
        label.text = "23:30"
        label.font = UIFont.init(name: "HelveticaNeue", size: 11)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "ARSENAL VS MAN UTD"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let KOLabel: UILabel = {
        let label = UILabel()
//        label.text = "K.O"
//        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
//        label.textAlignment = .center
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15)  )
        label.font = UIFont(name: "FontAwesome", size: 15)
        let myChar: UniChar = 0xf1e3
        label.text = String(format: "%C", myChar)
        label.textColor = UIColor.white
//        label.backgroundColor = .red
        return label
    }()
    
    var koTime = Timer()
    var koDate: NSDate?
    
    
    
    
    
    override func setupViews() {
        super.setupViews()
        
        //Menampilkan component pada header cell
        addSubview(headerImage)
        addSubview(headerViewBottom)
        addSubview(timeView)
        addSubview(timeLabel)
        addSubview(kompetisiLabel)
        addSubview(jamKOLabel)
        addSubview(teamLabel)
        addSubview(KOLabel)
        
        countdownTimeKO()
        
        //Set image pada headerimageview dan ubah ukuran gambar
        headerImage.image = UIImage(named: "header")?.resizeImage(frame.width, opaque: false)
        
        
        //MARK: Auto layout header cell
        _ = headerImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = headerViewBottom.anchor(headerImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = timeView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        timeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeView.centerYAnchor.constraint(equalTo: headerViewBottom.topAnchor).isActive = true
        
        _ = timeLabel.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor, constant: 10).isActive = true
        
        _ = kompetisiLabel.anchor(headerViewBottom.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 20)
        kompetisiLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        _ = jamKOLabel.anchor(kompetisiLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 20)
        jamKOLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        _ = teamLabel.anchor(jamKOLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 30)
        teamLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        _ = KOLabel.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        KOLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        KOLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor, constant: -10).isActive = true
        
        
        
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    func timeString(time: TimeInterval) -> String {
        
        let hour = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hour, minutes, seconds)
    }
    
    //MARK: Method hitung mundur waktu Kick Off
    func countdownTimeKO() {
        
        let koDateString = "2019-03-15 08:00:00"
        let koDateFormat = DateFormatter()
        koDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        koDate = koDateFormat.date(from: koDateString)! as NSDate
        
        koTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        
    }
    
    //MAR: Method update label dengan countdown
    @objc func timerRunning() {
        
        let currentDate = Date()
        let calender = Calendar.current
        
        let difDateComponents = calender.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: koDate! as Date)

        let minutes = twoDigit(int: difDateComponents.minute!)
        let seconds = twoDigit(int: difDateComponents.second!)
        let countDown = "\(difDateComponents.hour ?? 0):\(minutes):\(seconds)"
        
        timeLabel.text = countDown
        
    }
    
    //MARK: Method konfersi number dengan nilai di bawah 10 menjadi "0x"
    fileprivate func twoDigit(int: Int) -> String {
        var digit = "\(int)"
        if (int <= 9){
            digit = "0\(int)"
        }
        
        return digit
    }
}

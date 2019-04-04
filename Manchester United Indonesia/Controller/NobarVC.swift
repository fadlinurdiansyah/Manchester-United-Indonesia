//
//  NobarVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 27/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class NobarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    //MARK: Data dummy
    
    var nobar: [Nobar] = {
        
        let nobar1 = Nobar(idNobar: 1, lokasiNobar: "Bosih Futsal", homeTeam: "MUN", awayTeam: "ARS", tanggalKO: "2019-03-07", jamKO: "21:00", jenisLokasi: "Futsal", kota: "Bekasi Kab.", kecamatan: "Cibitung", htm: 0, fotoNobar: "nobar1", fotoDetailLolkasi: ["foto1","foto2","foto3","foto4","foto5","foto6"], descLokasi: "", latitude: -6.2443098 , longtitude: 107.0757401)
        
        let nobar2 = Nobar(idNobar: 2, lokasiNobar: "MU Cafe", homeTeam: "CHE", awayTeam: "MUN", tanggalKO: "2019-04-23", jamKO: "22:30", jenisLokasi: "Cafe", kota: "Jakarta", kecamatan: "Pancoran", htm: 25000, fotoNobar: "nobar2", fotoDetailLolkasi: ["foto21","foto22","foto23"], descLokasi: "", latitude: -6.1752377 , longtitude: 106.8260316)
        
        let nobar3 = Nobar(idNobar: 3, lokasiNobar: "Dagelan Cafe", homeTeam: "TOT", awayTeam: "MUN", tanggalKO: "2019-02-01", jamKO: "02:30", jenisLokasi: "Cafe", kota: "Cikarang", kecamatan: "Cibarusah", htm: 0, fotoNobar: "nobar3", fotoDetailLolkasi: ["foto1"], descLokasi: "", latitude: -6.1918646 , longtitude: 106.9760864)
        
        let nobar4 = Nobar(idNobar: 4, lokasiNobar: "Lap. Banteng", homeTeam: "MUN", awayTeam: "MCI", tanggalKO: "2019-10-19", jamKO: "20:30", jenisLokasi: "Lapangan", kota: "Jakarta", kecamatan: "Monas", htm: 20000, fotoNobar: "nobar4", fotoDetailLolkasi: [], descLokasi: "", latitude: -6.1173402 , longtitude: 106.8568954)
        
         let nobar5 = Nobar(idNobar: 5, lokasiNobar: "Soto Mang Dalang", homeTeam: "MUN", awayTeam: "WHU", tanggalKO: "2019-07-05", jamKO: "23:00", jenisLokasi: "Resto", kota: "Jakarta", kecamatan: "Pisangan", htm: 0, fotoNobar: "nobar5", fotoDetailLolkasi: [], descLokasi: "", latitude: -6.3023233 , longtitude: 106.8940669)
        
        let nobar6 = Nobar(idNobar: 6, lokasiNobar: "Warunk Upnormal", homeTeam: "MUN", awayTeam: "LIV", tanggalKO: "2019-05-23", jamKO: "20:00", jenisLokasi: "Resto", kota: "Bekasi", kecamatan: "Jaksampurna", htm: 15000, fotoNobar: "nobar4", fotoDetailLolkasi: [], descLokasi: "", latitude: -6.3114206 , longtitude: 106.8137378)
        
        return [nobar1, nobar2, nobar3, nobar4, nobar5, nobar6]
        
    }()
    
    /*------------UI Component--------------*/
    
    //MARK: Berita CollectionView
    lazy var nobarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 233, green: 235, blue: 238)
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    lazy var nobarMenuBarView: NobarMB = {
        let view = NobarMB()
        view.nobarVC = self
        
        return view
    }()
    
    let jarakView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.rgb(red: 233, green: 235, blue: 238).cgColor
        return view
    }()
    
    let jarakLabel: UILabel = {
        let label = UILabel()
        label.text = "Jarak 100 KM"
        label.font = UIFont.init(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.black
        label.textAlignment = .left
//        label.backgroundColor = .yellow
        return label
    }()
    
    let jarakImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "location")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
//        iv.backgroundColor = .blue
        return iv
    }()
    
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "NOBAR YUUUKK"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        return label
    }()
    
    let statusBarBackgroundView = UIView() //set background status bar
    
    /*---------Declaration Variable-----------------*/
    
    
    let nobarCellId = "nobarCellId" //id untuk cell nobar
    var jarakViewConstraint: NSLayoutConstraint? //Variable untuk constraint awal jarakView
    var nobarMenuBarViewConstraint: NSLayoutConstraint? //Variable untuk constraint awal menuBar
    var searchNobar: Bool = false //Variable untuk status searchNobar Array
    var filterNobar: [Nobar] = [] //Variable array awal filterNobar
    
    override func viewWillAppear(_ animated: Bool) {
        statusBarColor(color: UIColor.white, title: titleLabel2)
        
        self.view.addSubview(statusBarBackgroundView) //Memasukan uiview statusbar ke aplikasi / tampilan
        
        //Auto layout status bar view
        _ = statusBarBackgroundView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarColor(color: UIColor.white, title: titleLabel2)
        
        view.addSubview(statusBarBackgroundView) //Memasukan uiview statusbar ke aplikasi / tampilan
        
        //Auto layout status bar view
        _ = statusBarBackgroundView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        view.backgroundColor = UIColor.rgb(red: 233, green: 235, blue: 238)
        navigationItem.title = "NOBAR YUUK"
        
        //Register cell pada uicollectionview
        nobarCollectionView.register(NobarCell.self, forCellWithReuseIdentifier: nobarCellId)
        
        view.addSubview(nobarCollectionView)
        view.addSubview(nobarMenuBarView)
        
        _ = nobarCollectionView.anchor(nobarMenuBarView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        nobarMenuBarViewConstraint = nobarMenuBarView.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40).first
        
        
        setupJarakView()
        

    }

    //jumlah collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //Jika variable searchNobar bernilai true maka jumlah collectionview sejumlah dengan array filterNobar
        if searchNobar {
            return filterNobar.count
        } else {
            return nobar.count
        }
        
    }
    
    //looping collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = nobarCollectionView.dequeueReusableCell(withReuseIdentifier: nobarCellId, for: indexPath) as! NobarCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        //Jika variable searchNobar bernilai true maka isi cell nobar sesuai dengan arrau filterNobar
        if searchNobar {
            cell.nobar = filterNobar[indexPath.row]
        } else {
            cell.nobar = nobar[indexPath.row]
        }
        
        return cell
    }
    
    //Menentukan ukuran collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width -  10 - 10, height: 120)
    }
    
    //Mengyembunyikan searchbar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        if y >= 10 {
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                let y = scrollView.contentOffset.y * -1
                if y <= -40 {
                   return
                } else {
                     self.nobarMenuBarViewConstraint?.constant = y
                }
            }, completion: nil)

        } else {
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.nobarMenuBarViewConstraint?.constant = 0
            }, completion: nil)

        }
    }
    
    //MARK: Method tampil detail nobar ViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailNobarVC = DetailNobarVC() //Membuat variable dari class detainobarVC
        let backItem = UIBarButtonItem() //Membuat variable dari UIBarButtonItem
        backItem.title = "" //Menghilangkan text di samping tombol back
        navigationItem.backBarButtonItem = backItem //Set style tombol back button
        
        //Passing data nobar ke detail nobar
        if searchNobar == true {
            detailNobarVC.nobar = filterNobar[indexPath.item]
        } else {
            detailNobarVC.nobar  = nobar[indexPath.item]
        }
        
        detailNobarVC.hidesBottomBarWhenPushed = true //Mehilangkan tabbar pada saat detail nobarVC tampil
        navigationController?.pushViewController(detailNobarVC, animated: true) //Menampilkan detail nobarVC
        
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    fileprivate func setupJarakView() {
        view.addSubview(jarakView)
        
        jarakView.addSubview(jarakImageView)
        jarakView.addSubview(jarakLabel)
        
        
        jarakViewConstraint = jarakView.anchor(nobarMenuBarView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 95, heightConstant: 25).first
        jarakView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _ = jarakImageView.anchor(nil, left: jarakView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        jarakImageView.centerYAnchor.constraint(equalTo: jarakView.centerYAnchor).isActive = true
        
        _ = jarakLabel.anchor(nil, left: jarakImageView.rightAnchor, bottom: nil, right: jarakView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        jarakLabel.centerYAnchor.constraint(equalTo: jarakView.centerYAnchor).isActive = true
        
        
    }
    
    
    //MARK: Method untuk filter isi array berdasarkan text dari UISerachbar
    func filterNobarContent(text: String) {
        
        filterNobar = nobar
            .filter { $0.kota.localizedStandardContains(text) } //Filter array incase sensitive (tidak case sensitive)
            .sorted { $0.tanggalKO < $1.tanggalKO } //Sort array berdasarkan key tanggalKO terkecil s/d terbesar
        
        //Jika nilai array setelah input text pada UISearchbar 0 (nil) maka ditampilkan semua isi array
        if filterNobar.count == 0 {
            searchNobar = false
        } else {
            searchNobar = true
        }
        
        //Reload / refresh collectionview
        self.nobarCollectionView.reloadData()
        
    }
    
    
    //MARK: Method ubah warna dan title nav & status bar
    public func statusBarColor(color: UIColor, title: UIView) {
        
        //Set status bar dan navigation bar
        
        if (color != UIColor.clear) {
            
            self.statusBarBackgroundView.isHidden = false //Menyembunyikan status bar
            
        } else {
            
            self.statusBarBackgroundView.isHidden = false //Menampilkan status bar
            
        }
        
        //Set navigation title pada tab bar berita
        self.navigationItem.titleView = title //Set navigation bar title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //Menghilangkan background navbar
        self.navigationController?.navigationBar.shadowImage = UIImage() //Menghilangkan line hitam dibawah navbar
        self.navigationController?.navigationBar.isTranslucent = true //Set navbar menjadi transparant
        self.navigationController?.navigationBar.backgroundColor = color //Set warna background navbar
        
    }
    
    

}

//
//  DetailNobarVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 23/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

protocol expandedCellDelegate: NSObjectProtocol {
    
    func topButtonTouched(indexPath: IndexPath)
    
}


class DetailNobarVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, expandedCellDelegate {
    

    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //Data dummy
    var nobar: Nobar?
    
    
    /*------------UI Component--------------*/
    
    lazy var detailNobarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 233, green: 235, blue: 238)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        return label
    }()
    
    /*---------Declaration Variable-----------------*/
    
    let fotoNobarCellId = "fotoNobarCellId" //Variable header cell id
    let mapLokasiCellId = "mapLokasiCellId" //Variable id cell map lokasi
    let facilityCellId = "facilityCellId" // Variable id cell facility
    var expandSection = [Bool]()
    var expandHeight: CGFloat = 350
    var notExpandHeight: CGFloat = 56
    
    
    /*---------Load Component-----------------*/

    override func viewWillAppear(_ animated: Bool) {
        //Set navbar awal
        setupNavbar()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Register header cell pada collectionView
        detailNobarCollectionView.register(HeaderDetailNobar.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fotoNobarCellId)
        
        //Register content cell pada collectionView
        detailNobarCollectionView.register(MapLokasiCell.self, forCellWithReuseIdentifier: mapLokasiCellId)
        detailNobarCollectionView.register(FacilityCell.self, forCellWithReuseIdentifier: facilityCellId)
        
        //menambahkan component UIKit pada tampilan aplikasi
        view.addSubview(detailNobarCollectionView)
        
        //MARK: Autolayout
        _ = detailNobarCollectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: self.topBarHeight * -1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.expandSection = [Bool](repeating: true, count: 3)
        
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    /* --------------------------- UIComponent Function ------------------------------*/
    
    //Menentukan jumlah cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    //Menentukan cell pada header collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = detailNobarCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: fotoNobarCellId, for: indexPath) as! HeaderDetailNobar
        header.nobar = nobar!
        header.shareButton.addTarget(self, action: #selector(shareNobar(sender:)), for: UIControl.Event.touchUpInside)
        return header
    }
    
    //Menentukan cell pada content collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            
            let cell = detailNobarCollectionView.dequeueReusableCell(withReuseIdentifier: facilityCellId, for: indexPath) as! FacilityCell
            cell.indexPath = indexPath
            cell.delegate = self
            if expandSection[indexPath.row] == true {
                cell.setupView(hidden: false)
            } else {
                cell.setupView(hidden: true)
            }
            
            return cell
        
        } else {
            
            let cell = detailNobarCollectionView.dequeueReusableCell(withReuseIdentifier: mapLokasiCellId, for: indexPath) as! MapLokasiCell
            cell.indexPath = indexPath
            cell.delegate = self
            cell.nobar = nobar!
            if expandSection[indexPath.row] == true {
                cell.setupView(hidden: false)
            } else {
                cell.setupView(hidden: true)
            }
            return cell
            
        }
        
       
        
    }
    
    //Menetukan ukuran cell header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if expandSection[indexPath.row] == true {
            
            return CGSize(width: view.frame.width, height: expandHeight)
            
        } else {
            
            return CGSize(width: view.frame.width, height: notExpandHeight)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: Transisi navigation bar dari clear menjadi ada warna dan title
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        //menentukan nilai offset jika scrollview di poisis 150 point
        let offset = scrollView.contentOffset.y / 150
        
        //Jika offset lebih dari 1 maka transparansi warna status bar dan navbar berubah
        if offset > 1 {
            
            //Non Tranparant
            let color = UIColor.rgbAlpha(red: 255, green: 255, blue: 255, alpha: offset)
            let tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
    
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.backgroundColor = color
            
            UIApplication.shared.statusBarView?.backgroundColor = color
            UIApplication.shared.statusBarView?.tintColor = color
            UIApplication.shared.statusBarStyle = .default //Merubah warna text status bar menjadi hitam
            
        } else {
            //Transparant
            let color = UIColor.rgbAlpha(red: 255, green: 255, blue: 255, alpha: offset)
            let tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.backgroundColor = color
            
            UIApplication.shared.statusBarView?.backgroundColor = color
            UIApplication.shared.statusBarView?.tintColor = color
            UIApplication.shared.statusBarStyle = .lightContent //Merubah warna text status bar menjadi putih
            
        }
    }
    
    /* --------------------------- Manual Function ------------------------------*/
    
    //MARK: Method ubah warna dan title nav & status bar
     func setupNavbar() {
    
        //Menambahkan button item pada posisi kanan navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart")?.resizeImage(20, opaque: false), style: UIBarButtonItem.Style.plain, target: self, action: nil)
        
        self.navigationController?.navigationBar.makeTransparant()

    }
    
    //MARK: Method untuk action share link,text atau image
    @objc private func shareNobar(sender: CustomeShareButton) {
        
        guard let text = sender.text, let link = sender.link else { return } //set variable text dan link
        
        //set activityControler kirim nilai text dan link
        let activityVC = UIActivityViewController(activityItems: ["Ayo Nonton Bareng MU vs ARS di \(text)","\(link)"], applicationActivities: nil)
        
        //Menentukan sumber pop over activityVC
        activityVC.popoverPresentationController?.sourceView = self.view
        
        //Menampilkan activityVC
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    /* --------------------------- Protocol Function ------------------------------*/
    
    func topButtonTouched(indexPath: IndexPath) {
        
        expandSection[indexPath.row] = !expandSection[indexPath.row]
        UIView.animate(withDuration: 1) {
            self.detailNobarCollectionView.reloadItems(at: [indexPath])
            print("Berhasil \(indexPath.row)")
        }

    }
    
}

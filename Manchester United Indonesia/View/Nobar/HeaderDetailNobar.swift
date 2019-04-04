//
//  DetailFotoNobarCell.swift
//  Manchester United Indonesia
//
//  Created by NDS on 23/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class HeaderDetailNobar: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //Data Dummy
    var nobar: Nobar? {
        didSet {
            fotoCollectionView.reloadData()
            if let numRow = nobar?.fotoDetailLolkasi.count {
                fotoPageControl.numberOfPages = numRow
            }
            shareButton.link = "http://google.com"
            shareButton.text = nobar?.lokasiNobar
        }
    }
    
    /*------------UI Component--------------*/
    
    lazy var fotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.clipsToBounds = true
        layout.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        return cv
    }()
    
    let fotoPageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.white
        pc.currentPageIndicatorTintColor = UIColor.red
        pc.hidesForSinglePage = true
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    let matchLabel: UILabel = {
        let label = UILabel()
        label.text = "MUN vs ARS | 23.30 Wib"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        return label
    }()
    
    let nameLokasiNobarLabel: UILabel = {
        let label = UILabel()
        label.text = "Manchester United Cafe"
        label.font = UIFont.init(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var shareButton: CustomeShareButton = {
        let button = CustomeShareButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(named: "share-1"), for: UIControl.State.normal)
        button.tintColor = UIColor.red
        button.layer.masksToBounds = true
        return button
    }()
    
    let ratingImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rating")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        iv.tintColor = UIColor.red
        return iv
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.0 Sangat Seru (100 Review)"
        label.font = UIFont.init(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.black
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        return view
    }()
    
    /*---------Declaration Variable-----------------*/
    
    let cellId = "cellId"
    
    //Set variable untuk memanggil class ZoomFotoLauncher
    lazy var zoomFotoLauncher: ZoomFotoLauncher = {
        let launcher = ZoomFotoLauncher()
        return launcher
    }()
    
    
    
    /*---------Load Component-----------------*/
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white
        
        //Display UI Component
        addSubview(fotoCollectionView)
        addSubview(fotoPageControl)
        addSubview(matchLabel)
        addSubview(nameLokasiNobarLabel)
        addSubview(shareButton)
        addSubview(ratingImage)
        addSubview(ratingLabel)
        addSubview(lineView)
        
        //Register Cell pada collectionView
        fotoCollectionView.register(FotoCell.self, forCellWithReuseIdentifier: cellId)
        
        
        //MARK: Autolayout
        _ = fotoCollectionView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 250)
        
        _ = fotoPageControl.anchor(nil, left: leftAnchor, bottom: fotoCollectionView.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = matchLabel.anchor(fotoCollectionView.bottomAnchor, left: leftAnchor, bottom: nil, right: shareButton.leftAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = nameLokasiNobarLabel.anchor(matchLabel.bottomAnchor, left: matchLabel.leftAnchor, bottom: nil, right: matchLabel.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = ratingImage.anchor(nameLokasiNobarLabel.bottomAnchor, left: nameLokasiNobarLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 12, heightConstant: 12)
        
        _ = ratingLabel.anchor(ratingImage.topAnchor, left: ratingImage.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = shareButton.anchor(matchLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 15, heightConstant: 18)
        
        _ = lineView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    
    /* --------------------------- UIComponent Function ------------------------------*/
    
    //Menentukan jumlah cell pada collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = nobar?.fotoDetailLolkasi.count {
            return count
        }
        return 0
        
    }
    
    //Memnentukan class cell pada collectionview
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fotoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FotoCell //Menentukan style class dari FotoCell
        if let fotoName = nobar?.fotoDetailLolkasi[indexPath.item] {
            cell.fotoImage.image = UIImage(named: fotoName)?.resizeImage(frame.width, opaque: true) //Set image pada FotoCell
        }
        return cell
    }
    
    //Menentukan ukuran collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print(frame.width)
        return CGSize(width: frame.width, height: frame.height)
    }
    
    
    //Menentukan line spacing dari collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //Menentukan action pada saat cell di pilih
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let indexItem = indexPath
        zoomFotoLauncher.indexFoto = indexItem
        zoomFotoLauncher.onceOnly = false
        zoomFotoLauncher.showZoomImage()
        zoomFotoLauncher.nobar = nobar!
      
    }
    
    //Menentukan perubahan posisi page control pada saat selesai drag
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = targetContentOffset.pointee.x / frame.width //Mendapatkan nilai pageControl
        print(pageNumber)
        fotoPageControl.currentPage = Int(pageNumber) //Set nilai pagecontrol
        
    }
    
    
    /* --------------------------- Manual Function ------------------------------*/
    
    
}

private class FotoCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    /*------------UI Component--------------*/
    
    let fotoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    /*---------Declaration Variable-----------------*/
    
    override func setupViews() {
        super.setupViews()
        
        //Display UIcomponent
        addSubview(fotoImage)

        
        //MARK: Autolayout
        _ = fotoImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}


//MARK: Class button share (set attribute text dan link)
class CustomeShareButton: UIButton {
    var text: String?
    var link: String?
}

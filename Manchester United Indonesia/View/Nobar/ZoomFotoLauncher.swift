//
//  ZoomImageView.swift
//  Manchester United Indonesia
//
//  Created by NDS on 23/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class ZoomFotoLauncher: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    var nobar: Nobar? {
        didSet {
            fotoCollectionView.reloadData()
        }
    }

    /*------------UI Component--------------*/
    
    let blackView = UIView()
    
    lazy var fotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
//        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "close"), for: UIControl.State.normal)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    /*---------Declaration Variable-----------------*/
    
    let cellId = "cellId"
    var onceOnly = false
    var indexFoto: IndexPath?

    //Menentukan jumlah item pada collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = nobar?.fotoDetailLolkasi.count {
            return count
        }
        return 0
    }
    
    //Menentukan class cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fotoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ZoomCell // set style cell dari ZoomCell
        
        //Set image pada fotoimage
        if let fotoNobar = nobar?.fotoDetailLolkasi[indexPath.item] {
            cell.fotoImage.image = UIImage(named: fotoNobar)
        }
        return cell
    }
    
    //Menentukan ukuran collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: blackView.frame.width  , height: blackView.frame.height)
    }
    
    //Menentukan jarak spasi antara cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !onceOnly {
            print(indexFoto!)
            fotoCollectionView.scrollToItem(at: indexFoto! , at: UICollectionView.ScrollPosition.left, animated: false
            )
            onceOnly = true
        }
        
    }
    
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    //MARK: Method show windows Zoom Image, parameter indexpath untuk menentukan posisi image pada saat frame tampil
    func showZoomImage() {
        
      
        //Set window zoomimage
        if let window = UIApplication.shared.keyWindow {
            
            
            //Display UI component
            window.addSubview(blackView)
            window.addSubview(fotoCollectionView)
            window.addSubview(cancelButton)
            
            fotoCollectionView.register(ZoomCell.self, forCellWithReuseIdentifier: cellId) //register cell
            
            blackView.backgroundColor = UIColor.black //warna background uiview
    
            //menentukan action close uiwindow pada saat tombol di tekan
            cancelButton.addTarget(self, action: #selector(dismissZoomFoto), for: UIControl.Event.touchUpInside)
            
            blackView.alpha = 0 //set uiview transparant
            
            //Set posisi windows dari kanan layar
            let x = (window.frame.width / 2 ) + window.frame.width //menentukan posisi x view di luar window
            blackView.frame = CGRect(x: x , y: 0  , width: 10, height: window.frame.height) //menetukan ukuran awal view
            self.fotoCollectionView.frame = CGRect(x: x, y: 0, width: 10, height: window.frame.height) // menentukan ukuran awal collectionview
            
        
            //Animasi merubah ukuran view & collection view manjadi full frame
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                
                self.blackView.alpha = 1 //set view menjadi tidak transaparnt
                self.blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height) //merubah view menjadi full layar
                self.cancelButton.frame = CGRect(x: 15, y: 25, width: 30, height: 30) //menampilkan tombol cancel
                self.fotoCollectionView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height) //merubah collectionview menjadi full layar
            }) { (true) in
              
            }
        }
        
    }

    //MARK: Method close uiwindow zoomImage
    @objc func dismissZoomFoto() {
        
        
        //Animasi menghilangkan UIWindows
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            self.blackView.alpha = 0 //set view menjadi transparant
            
            if let window = UIApplication.shared.keyWindow {
                
                let x = (window.frame.width / 2 ) + window.frame.width //Menentukan posisi
                self.blackView.frame = CGRect(x: x , y: 0  , width: 10, height: window.frame.height) //mengrubah view kembali ke ukuran awal
                self.fotoCollectionView.frame = CGRect(x: x, y: 0, width: 10, height: window.frame.height) //mengrubah collectionview kembali ke ukuran awal
                self.cancelButton.frame = CGRect(x: x, y: 0, width: 0, height: 0) //mehilangkan cancel button
            }
            
            
        }, completion: nil)
    }
    
}

class ZoomCell: BaseCell {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    /*------------UI Component--------------*/
    let fotoImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    
    /*---------Declaration Variable-----------------*/
    
    
    
    override func setupViews() {
        super.setupViews()
        
        //Display ui component
        addSubview(fotoImage)
        
        backgroundColor = UIColor.black //set warna cell
        
        //setting action pinch gesture pada image
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomImage))
        fotoImage.addGestureRecognizer(pinchGesture)
 
        
        //Auto Layout
        _ = fotoImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    //MARK: Method zoom image
    @objc func zoomImage(sender:UIPinchGestureRecognizer) {
        
        //Menetukan component untuk diubah nilai scale
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        
        let lockWidthSize = sender.view?.frame.width //kunci ukuran agar tidak boleh di zoom in
        
        //Menentukan zoom out
        if Int(lockWidthSize ?? 0) <= Int(self.window?.frame.width ?? 0) {
            sender.view?.transform = CGAffineTransform.identity //Mematikan fungsi zoom in dan mengebalikan ukuran image jika di zoom in
        } else {
            sender.scale = 1 //Zoom Out
        }

    }

}


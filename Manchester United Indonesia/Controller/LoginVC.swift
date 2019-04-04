//
//  ViewController.swift
//  Manchester United Indonesia
//
//  Created by NDS on 27/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class LoginVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    let pageCellId = "pageCellId"
    
    // Membuat UICollectionView
    lazy var collectionViewLogin: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    //Membuat UIPageControl
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 253, green: 0, blue: 84)
        pc.numberOfPages = 4
        return pc
    }()
    
    //Membuat Button
    let skipButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Skip", for: UIControl.State.normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Next", for: UIControl.State.normal)
        button.tintColor = UIColor.white
        return button
    }()
    

    //Pertama kali code di eksekusi setelah tampilan berhasi di tampilkan
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         -----------------------------------------------------
         UIComponent
         -----------------------------------------------------
         */
        
        view.addSubview(collectionViewLogin)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        collectionViewLogin.register(PageCell.self, forCellWithReuseIdentifier: pageCellId)
        
        
        
        /*
         -----------------------------------------------------
         Auto Layout UIComponent
         -----------------------------------------------------
         */
        
        _ = collectionViewLogin.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 30, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _ = skipButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 10, rightConstant: 0, widthConstant: 50, heightConstant: 20)
        
        _ = nextButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 16, widthConstant: 50, heightConstant: 20)
    }
    
    
    /*
     -----------------------------------------------------
     Collectionview component
     -----------------------------------------------------
    */
 
    //Set jumlah item UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    //Set menentukan cell (UICollectionViewCell) pada UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //deklarasi UICollectionViewCell menjadi variable cell
        let cell = collectionViewLogin.dequeueReusableCell(withReuseIdentifier: pageCellId, for: indexPath) as! PageCell
        return cell
        
    }
    
    //Set ukuran UICollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
    
    //Set aksi pada saat UICollectionView di drag
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Aksi pindah page pada pageControl
        print(targetContentOffset.pointee.x)
        print(view.frame.width)
        let pageNumber = targetContentOffset.pointee.x / view.frame.width
        pageControl.currentPage = Int(pageNumber)
        
        if pageControl.currentPage == 3 {
            
            showHomeController()
            
        }
        
    }
    
    //MARK: Method menampilkan Home Tabbar Controller
    func showHomeController() {
        UIApplication.shared.keyWindow?.rootViewController = HomeTC()
        
    }


}


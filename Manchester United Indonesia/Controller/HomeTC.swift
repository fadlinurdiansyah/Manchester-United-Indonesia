//
//  HomeTC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 27/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit


class HomeTC: UITabBarController {

    //Pertama kali code di eksekusi setelah tampilan berhasi di tampilkan
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
    }
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    // Settingan UITabBarItem
    func setupTabBarItem() {
        
        //Setting tabbar dan view controller berita
        let homeNavigationController = UINavigationController(rootViewController: BeritaVC())
        homeNavigationController.tabBarItem.image = UIImage(named: "Berita") //Set image tabbar
        homeNavigationController.tabBarItem.title = "Berita" //Set judul tabbar
        
        //Setting tabbar dan view controller pertandingan
        let pertandinganNavigationController = UINavigationController(rootViewController: PertandinganVC())
        pertandinganNavigationController.tabBarItem.image = UIImage(named: "Pertandingan") //Set image tabbar
        pertandinganNavigationController.tabBarItem.title = "Pertandingan" //Set judul tabbar
        
        //Setting tabbar dan view controller klasemen
        let klasemenNavigationController = UINavigationController(rootViewController: KlasemenVC())
        klasemenNavigationController.tabBarItem.image = UIImage(named: "Klasemen") //Set image tabbar
        klasemenNavigationController.tabBarItem.title = "Klasemen" //Set judul tabbar
        
        //Setting tabbar dan view controller nobar
        let nobarNavigationController = UINavigationController(rootViewController: NobarVC())
        nobarNavigationController.tabBarItem.image = UIImage(named: "Nobar") //Set image tabbar
        nobarNavigationController.tabBarItem.title = "Nobar" //Set judul tabbar
        
        //Set item tabbar
        viewControllers = [homeNavigationController,pertandinganNavigationController, klasemenNavigationController, nobarNavigationController]
      
        tabBar.isTranslucent = false //Set tabbar tidak transparant
        tabBar.tintColor = UIColor.white //Set tabbar warna icon / gambar
        tabBar.barTintColor = UIColor.black //Set tabbar warna background
      
        
    }
    
    
    
}

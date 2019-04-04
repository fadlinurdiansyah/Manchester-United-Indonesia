//
//  HomeVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 27/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class BeritaVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    //MARK: Data Dummy
    var berita: [Berita] = {
        let berita1 = Berita(gambar: UIImage(named: "mu1")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
            let berita2 = Berita(gambar: UIImage(named: "mu2")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
            let berita3 = Berita(gambar: UIImage(named: "mu3")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
        let berita4 = Berita(gambar: UIImage(named: "mu4")!, description: """
            That's a wrap! Selengkapnya #KonferensiPersOle jelang laga #ARSMUN dapat disimak di timeline MUW. Berikut ringkasannya.
            1. Eric Bailly bugar
            2. Kondisi Herrera-Matic 50/50
            3. United lolos ke QF CL bukan kejutan
            4. Sekarang fokus ke Arsenal
            5. Masa depan? Tunggu musim panas
            6. Senang bisa bekerja di United
            7. Ole positif dan optimis udah dari dulu
            8. Pemilihan skuad tidak akan mudah
            9. Scott, Fred, dan Andreas bisa diandalin
            10. Scott dan Fred mungkin diistirahatkan
            11. Manajer sukses ga harus eks pemain
            12. Semoga Rash bisa jadi legenda klub
            13. Rash masih 21 tahun, inkonsistensi wajar
            14. Rash mesti lebih tajam di kotak penalti
            """)
            let berita5 = Berita(gambar: UIImage(named: "mu5")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
            let berita6 = Berita(gambar: UIImage(named: "mu6")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
            let berita7 = Berita(gambar: UIImage(named: "mu7")!, description: "ALERI - PSG 1 United 3. What a night! Dwigol Lukaku di babak pertama dan gol penalti Rashford di menit-menit terakhir laga mengantarkan United ke perempat final berkat agresivitas gol tandang. #PSGMUN #UCL")
        return [berita1, berita2, berita3, berita4, berita5, berita6, berita7]
        
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "ARSENAL VS MAN UTD"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        return label
    }()
    
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        return label
    }()
    
    //MARK: Berita CollectionView
    lazy var beritaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 233, green: 235, blue: 238)
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    /*---------Declaration Variable-----------------*/
    
    // Id cell berita
    let beritaCellId = "beritaCellId" //Set id cell berita
    let headerCellId = "headerCellId" //Set id header cell berita
    fileprivate var color: UIColor = UIColor(white: 0, alpha: 0) //set variable color untuk menetukan warna navbar

    //Pertama kali program di eksekusi pada saat tampilan akan tampil
    override func viewWillAppear(_ animated: Bool) {
        //Merubah warna status bar sesuai dengan warna pada offset
        setupNavBar(color: color)
        //Merubah warna status bar sesuai dengan warna pada offset
        statusBar(color: color)
        
    }
    
    //Pertama kali code di eksekusi setelah tampilan berhasi di tampilkan
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //Menampilkan component pada cell
        view.addSubview(beritaCollectionView)
        
        //Set register collectionviewcell berita
        beritaCollectionView.register(BeritaCell.self, forCellWithReuseIdentifier: beritaCellId)
        beritaCollectionView.register(BeritaHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        //MARK: Auto layout beritaVC
        _ = beritaCollectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: self.topBarHeight * -1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    //MARK: Set total row pada collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return berita.count
    }
    
    //MARK: Set isi dan desain cell pada collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = beritaCollectionView.dequeueReusableCell(withReuseIdentifier: beritaCellId, for: indexPath) as! BeritaCell
        cell.berita = berita[indexPath.item]
        return cell
    }
    
    //MARK: Set ukuran collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimasiHeight = estimatedHeighForTextAndImage(text: berita[indexPath.item].description, image: berita[indexPath.item].gambar.resizeImage(view.frame.width, opaque: false, contentMode: UIView.ContentMode.scaleAspectFit))
//        return CGSize(width: view.frame.width, height: 700)
        print(estimasiHeight)
        return CGSize(width: view.frame.width, height: estimasiHeight)
    }
    
    //MARK: Set spasi jarak antara cell 1 dan cell lainnya
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    //MARK: Setting collection view header cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = beritaCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! BeritaHeader
        return header
    }
    
    //MARK: Sett ukuran collection view header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        //Menentukan estimasi ukuran tinggi image header
        guard let estimasiHeightHeader = UIImage(named: "header")?.resizeImage(view.frame.width, opaque: false) else {
            fatalError()
        }
        
        return CGSize(width: view.frame.width, height: CGFloat(estimasiHeightHeader.size.height) + 120)
    }
    
    
    //MARK: Transisi navigation bar dari clear menjadi ada warna dan title
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        //menentukan nilai offset jika scrollview di poisis 150 point
        let offset = scrollView.contentOffset.y / 150
        
        //Jika offset lebih dari 1 maka transparansi warna status bar dan navbar berubah
        if offset > 1 {
            
            //Non Tranparant
            color = UIColor.rgbAlpha(red: 75, green: 76, blue: 82, alpha: offset)
            let tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.backgroundColor = color
            
            statusBar(color: color)
            
            //Animation memunculkan title
            let fadeTextAnimation = CATransition()
            fadeTextAnimation.duration = 5.0
            fadeTextAnimation.type = CATransitionType.fade
            navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            navigationItem.titleView = titleLabel
            
        } else {
            
            //Transparant
            color = UIColor.rgbAlpha(red: 75, green: 76, blue: 82, alpha: offset)
            let tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.backgroundColor = color
            
            statusBar(color: color)
            UIApplication.shared.statusBarStyle = .lightContent
            
            //Animation menghilangkan title
            let fadeTextAnimation = CATransition()
            fadeTextAnimation.duration = 5.0
            fadeTextAnimation.type = CATransitionType.fade
            navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            navigationItem.titleView = titleLabel2
            
            
        }
        
    }

        
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    //MARK: Setup navigationbar
    func setupNavBar(color: UIColor) {

        //Set left navbar item
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Pemain"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showPemain))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.makeTransparant()
        self.navigationController?.navigationBar.backgroundColor = color
    }
    
    //MARK: Setup Statusbar
    func statusBar(color: UIColor) {
        
        UIApplication.shared.statusBarView?.backgroundColor = color
        UIApplication.shared.statusBarView?.tintColor = color
        
        
    }
    
    @objc func showPemain() {
        print("Pemain")
    }
    
    //MARK: Estimasi tinggi text dan image
    private func estimatedHeighForTextAndImage(text: String, image: UIImage) -> CGFloat {
        let widthText = view.frame.width
        let heightImage = image.size.height
        let size = CGSize(width: widthText, height: 1000)
        let attributeText = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        
        let estimatedHeightFrame = NSString(string: text).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributeText, context: nil)
        
        return estimatedHeightFrame.height + heightImage + 53
        
    }
    

}

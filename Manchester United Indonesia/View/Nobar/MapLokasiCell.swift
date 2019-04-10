//
//  DetailNobarCell.swift
//  Manchester United Indonesia
//
//  Created by NDS on 23/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapLokasiCell: BaseCell, CLLocationManagerDelegate, MKMapViewDelegate {
    
    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    var nobar: Nobar? {
        didSet {
            guard let latitude = nobar?.latitude, let longtitude = nobar?.longtitude, let title = nobar?.lokasiNobar else { fatalError() }
            tesLocation(latitude: latitude, longtitude: longtitude, title: title)
        }
    }
    
    /*------------UI Component--------------*/
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail Lokasi"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("^", for: UIControl.State.normal)
        return button
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        return view
    }()
    
    let detailLokasiText: UITextView = {
        let tv = UITextView()
        tv.text = "Silahkan datang untuk nobar di: MU Cafe (Cibitung Kab. Bekasi), Jl. Bosih 1 No. 24, Bosih Raya, Kab. Bekasi 17520 Indonesia"
        tv.font = UIFont.init(name: "HelveticaNeue", size: 12)
        tv.textColor = UIColor.rgb(red: 43, green: 32, blue: 36)
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    let lokasiMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsBuildings = true
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var arahButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Arah", for: UIControl.State.normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.rgb(red: 168, green: 0, blue: 56).cgColor
        button.layer.shadowOffset = CGSize(width: 1 , height: 1)
        button.layer.shadowRadius = 5.0
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    
    
    /*---------Declaration Variable-----------------*/
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100
    var indexPath: IndexPath!
    weak var delegate: expandedCellDelegate?
    
    
    /*---------Load Component-----------------*/
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white
        
        addSubview(titleLabel)
        addSubview(lineView)
        addSubview(detailLokasiText)
        addSubview(lokasiMapView)
        addSubview(arahButton)
        addSubview(expandButton)
        
        _ = titleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        _ = expandButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 50, heightConstant: 50)
        
        _ = lineView.anchor(expandButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        _ = detailLokasiText.anchor(lineView.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 70)
        
        _ = lokasiMapView.anchor(detailLokasiText.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 150)
        
        _ = arahButton.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        arahButton.centerXAnchor.constraint(equalTo: lokasiMapView.centerXAnchor).isActive = true
        arahButton.centerYAnchor.constraint(equalTo: lokasiMapView.bottomAnchor).isActive = true
    
        expandButton.addTarget(self, action: #selector(expand), for: UIControl.Event.touchUpInside)
        
        checkLocationService()
        
        setupView(hidden: true)
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    
    /* --------------------------- UIComponent Function ------------------------------*/
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
//        print("Latitude: \(location.coordinate.latitude) Longtitude: \(location.coordinate.longitude)")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        lokasiMapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkLocationAuthorization()
        
    }
    
    
    
    
    /* --------------------------- Manual Function ------------------------------*/
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            lokasiMapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to run this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            tesLocation(latitude: 0, longtitude: 0, title: "")
            break
        case .denied:
            // Show alert instructing them how turn on permission
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show an alert letting them know what`s up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func userLocation() {
        setupLocationManager()
        lokasiMapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
    }

    func tesLocation(latitude: Double, longtitude: Double, title: String) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let tesAnnotation = MKPointAnnotation()
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        lokasiMapView.setRegion(region, animated: true)
        tesAnnotation.coordinate = coordinate
        tesAnnotation.title = title
        lokasiMapView.addAnnotation(tesAnnotation)
    }
    
    @objc func expand() {
        if let delegate = self.delegate {
            delegate.topButtonTouched(indexPath: indexPath)
        }
    }
    
    func setupView(hidden: Bool) {
        
        if hidden == true {
            
            expandButton.transform = CGAffineTransform(rotationAngle: .pi)
            
        } else {

            expandButton.transform = CGAffineTransform.identity
        }
        
        self.detailLokasiText.isHidden = hidden
        self.lokasiMapView.isHidden = hidden
        self.arahButton.isHidden = hidden

    }
    

}

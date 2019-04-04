//
//  Data.swift
//  Manchester United Indonesia
//
//  Created by NDS on 07/03/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

struct Berita {
    let gambar: UIImage
    let description: String
}


struct Nobar {
    let idNobar: Int
    let lokasiNobar: String
    let homeTeam: String
    let awayTeam: String
    let tanggalKO: String
    let jamKO: String
    let jenisLokasi: String
    let kota: String
    let kecamatan: String
    let htm: Double
    let fotoNobar: String
    let fotoDetailLolkasi: [String]
    let descLokasi: String
    let latitude: Double
    let longtitude: Double
}

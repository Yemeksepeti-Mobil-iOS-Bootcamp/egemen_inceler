//
//  Yolcu.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 20.07.2021.
//

import Foundation

struct Yolcu{
    let id: Int
    let adi: String
    let soyadi: String
    let tc: String
    let hesKodu: String
    
    init(id: Int = 0, ad: String = "", soyad: String = "", tc: String = "-1", hes: String = "-"){
        self.id = id
        self.adi = ad
        self.soyadi = soyad
        self.tc = tc
        self.hesKodu = hes
    }
    
    func yazdir(){
        print("Yolcu: \(self.adi) \(self.soyadi), ID: \(self.id)")
    }
}

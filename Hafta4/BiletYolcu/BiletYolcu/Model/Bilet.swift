//
//  Bilet.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 20.07.2021.
//

import Foundation

struct Bilet{
    let yolcu: Yolcu?
    let tarih: Tarih?
    let saat: Saat?
    let koltuk: Int
    
    init(yolcu: Yolcu?, tarih: Tarih?, saat: Saat?, koltuk: Int = 0) {
        self.yolcu = yolcu
        self.tarih = tarih
        self.saat = saat
        self.koltuk = koltuk
    }
    
    func karsilastir(koltukNo: Int) -> Bool{
        for i in 1...45{
            if i == koltukNo{
                return true
            }
        }
        #warning("ui'da alert çıkart")
        return false
    }
    
    func koltukAyir(){
        
    }
    
    func koltukNoEkle(){
        
    }
    
    func yazdir(){
        print("Ad: \(self.yolcu?.adi) \(self.yolcu?.soyadi)-\(self.yolcu?.id), \(self.tarih?.gun)/\(self.tarih?.ay)/\(self.tarih?.yil), \(self.saat?.hour):\(self.saat?.dakika) | Koltuk No: \(self.koltuk)")
    }
}

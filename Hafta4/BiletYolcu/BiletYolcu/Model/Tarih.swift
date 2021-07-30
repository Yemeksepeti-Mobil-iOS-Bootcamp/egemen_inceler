//
//  Tarih.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 20.07.2021.
//

import Foundation

struct Tarih {
    let gun: String
    let ay: String
    let yil: String
    
    
    //  GG/AA/YY
    func toString() -> String{
        return ("Gün: \(self.gun) - Ay: \(self.ay) - Yil: \(self.yil)")
    }
    
    func getDate(){
        
    }
}

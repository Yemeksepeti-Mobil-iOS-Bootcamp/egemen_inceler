//
//  Saat.swift
//  BiletYolcu
//
//  Created by Egemen Inceler on 20.07.2021.
//

import Foundation

struct Saat{
    let hour: String
    let dakika: String
    
    init(saat: String, dakika: String){
        self.hour   = saat
        self.dakika = dakika
    }
    
    func toString() -> String{
        return "Saat: \(self.hour):\(self.dakika)"
    }
}

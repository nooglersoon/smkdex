//
//  ModelAlat.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 09/08/21.
//

import Foundation

struct Alat:Identifiable,Hashable {
    let id = UUID()
    let visual: String
    let nama: String
//    let alats: [Alat]
    
    init(nama: String,visual: String) {
        self.nama = nama
        self.visual = visual
//        self.alats = alats
    }
}

struct AlatManager{
        let alatAlat: [Alat] = [
        
            Alat(nama: "Amplas", visual: "Amplas"),
            Alat(nama: "Obeng", visual: "Obeng"),
            Alat(nama: "Tang", visual: "Tang")
        ]
}

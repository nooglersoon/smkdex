//
//  Model.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 18/07/21.
//

import Foundation
import UIKit
import Combine

struct Part: Identifiable, Hashable {
    
    let id = UUID()
    let nama: String
    let fungsi: String
    let visual: String
    
    init(nama: String, fungsi: String, visual: String) {
        self.nama = nama
        self.fungsi = fungsi
        self.visual = visual
    }
    
}

struct Component: Identifiable {
    
    let id = UUID()
    let nama: String
    let shortDesc: String
    let longDesc: String
    let visual: String
    let parts: [Part]
    let category: Categories
    
    init(nama: String, shortDesc: String, longDesc: String, visual: String, category: Categories, parts: [Part]) {
        
        self.nama = nama
        self.shortDesc = shortDesc
        self.longDesc = longDesc
        self.visual = visual
        self.category = category
        self.parts = parts
    }
    
    
}

struct ComponentManager {
    
    var allComponent = [Component]()
    
    init() {
        
        let klaksonPart: [Part] = [
            
            Part(nama: "Aki", fungsi: "Baterai (ACCU) pada sistem kelistrikan klakson berfungsi sebagai sumber listrik utama dengan arus DC (Direct Current) atau arus searah. Baterai ini memiliki tegangan sebesar 12 volt dan memiliki dua kutub yaitu positif dan negatif. Bila arus yang ada dibaterai mulai kosong maka akan berdampak pada bunyi klakson yang juga semakin melemah", visual: "Aki"),
            
            Part(nama: "Sekring", fungsi: "Fuse atau sering disebut sekering merupakan komponen pengaman pada jaringan kelistrikan, termasuk juga pada jaringan kelistrikan klakson. Fuse berfungsi untuk mencegah terjadinya kerusakan pada komponen lainnya bila terjadi hubungan singkat atau kelebihan tegangan. Fuse akan putus jika terjadi hubungan singkat atau beban arus berlebihan sehingga arus tersebut tidak akan mengalir ke komponen kelistrikan lainnya sehingga komponen kelistrikan lainnya akan aman dari kerusakan.", visual: "Fuse"),
            
            Part(nama: "Saklar Klakson", fungsi: "Pada dasarnya, sistem klakson menggunakan tipe saklar tekan, yaitu ketika saklar ditekan pada terjadi hubungan antara terminal klakson satu dengan yang lainnya. Pada sistem kelistrikan klakson dengan menggunakan pengendali negatif, saklar diletakkan dibagian jaringan negatif yaitu digunakan untuk memutus kan arus terminal 86 yang menuju ke massa atau negatif baterai.", visual: "TombolKlakson"),
        
            Part(nama: "Kunci Kontak", fungsi: "Kunci kontak berfungsi untuk memutuskan dan menghubungkan listrik pada rangkaian atau mematikan dan menghidupkan sistem di rangkaian kelistrikan klakson.", visual: "KunciKontak"),
            
            Part(nama: "Klakson", fungsi: "Klakson berfungsi sebagai sumber suara. Saat saklar klakson ditekan, arus dari baterai mengalir melalui baterai, terus ke coil (solenoid), menuju platina dan selanjutnya ke massa. Solenoid menjadi magnet dan menarik armature. Kemudian armature membukakan platina sehingga arus ke massa terputus. Dengan terputusnya arus tersebut, kemagnetan pada solenoid hilang, sehingga armature kembali ke posisi semula. Hal ini menyebabkan platina menutup kembali untuk menghubungkaan arus ke massa. Proses ini berlangsung cepat, dan diafragma membuat armature bergetar lebih cepat lagi, sehingga menghasilkan resonansi suara", visual: "Klakson"),
 
            
        ]
        
        let klakson = Component(nama: "Klakson", shortDesc: "A horn is a sound-making device that can be equipped to motor vehicles", longDesc: "Rangkaian klakson terdiri dari accu, klakson, saklae klakson, sekering, dan kunci kontak. rangkaian ini berfungsi untuk menghasilkan suara sebagai penanda atau isyarat saat berkendara.", visual: "Klakson", category: .electricity, parts: klaksonPart)
        
        allComponent.append(klakson)
        
    }
    
}

enum Categories: CaseIterable {
    
    case electricity
    
    var label: String {
        
        switch self {
        
        case .electricity:
            return "Motorcycle Electricity"
        
        }
        
    }
    
}

//
//  TestingView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 16/07/21.
//

import SwiftUI
import MobileCoreServices

struct DragDropSimulationView: View {
   
    @State private var isARPresented = false
    
    var parts: [Part]
    
    @ObservedObject var delegate = PartsDataObject()
    
    
    var body: some View {
            
            VStack{
                
                // Drop Area
                
                GeometryReader{ _ in
                    
                    ZStack {
                        
                        if delegate.selectedPart.isEmpty {
                            
                            Text("Drop Images Here")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                            
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            HStack {
                                
                                ForEach(delegate.selectedPart, id:\.nama){ image in
                                    
                                    if image.visual != ""{
                                        
                                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                            
                                            Image(image.visual)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .cornerRadius(15)
                                            
                                            // Remove button
                                            
                                            Button(action: {
                                                
                                                withAnimation(.easeOut) {
                                                    self.delegate.selectedPart.removeAll {
                                                        (check) -> Bool in
                                                        
                                                        if check.visual == image.visual {
                                                            return true
                                                        } else {
                                                            return false
                                                        }
                                                        
                                                    }
                                                }
                                                
                                            }, label: {
                                                Image(systemName: "xmark")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(Color.black)
                                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                            })
                                            
                                            
                                        })
                                        
                                    }
                                    
                                }
                                
                                Spacer(minLength: 0)
                                
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding()
                        
                    }
                    
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .padding(.top,10)
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: 430, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(.systemGray4).opacity(0.3))
                // Drop area which to receive provided data
  
                // receiving some data type
                .onDrop(of: [String(kUTTypeURL)], delegate: delegate)
                
                Spacer()
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    
                    VStack(alignment: .leading){
                        Text("Select Component")
                            .bold()
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            // Draggable Object
                            
                            HStack(alignment: .center){
                                
                                ForEach(parts, id: \.self){ part in
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color(.systemBackground))
                                            .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)), radius: 4, x: 3, y: 3)
                                        VStack(spacing: 5){
                                            Image(uiImage: UIImage(named: part.visual)!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                
                                            Text(part.nama)
                                                .font(.system(size: 13))
                                                .bold()
                                        }
                                    }
                                    .frame(width: 150, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .onDrag{
                                        
                                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                                    impactHeavy.impactOccurred()
                                        
                                        return NSItemProvider(item: .some(URL(string: part.visual)! as NSSecureCoding) , typeIdentifier: String(kUTTypeURL))
                                    }
                                    
                                }
                                
                            }
                            
                        }
                    }
                   
                    
                    GoToARButtonView(isARPresented: $isARPresented, actionView: {
                        isARPresented.toggle()
                    }, actionName: "Simulasi Rangkaian pada AR")
                    .disabled(delegate.checkButton() ? false : true)
                    .opacity(delegate.checkButton() ? 1 : 0.5)
                    .padding()
                }
                
                .fullScreenCover(isPresented: $isARPresented){
                    ARSimulationView()
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeOut) {
                    self.delegate.selectedPart.removeAll()
                }
            }, label: {
                Text("Reset")
            }))
            .navigationBarTitle("Circuit Simulation",displayMode: .inline)
            .onDisappear(){
                
                self.delegate.selectedPart.removeAll()
                
            }
    }
    
}


class PartsDataObject: ObservableObject, DropDelegate{
    
    @Published var parts: [Part] = [
        
        Part(nama: "Klakson", fungsi: "Klakson berfungsi sebagai sumber suara. Saat saklar klakson ditekan, arus dari baterai mengalir melalui baterai, terus ke coil (solenoid), menuju platina dan selanjutnya ke massa. Solenoid menjadi magnet dan menarik armature. Kemudian armature membukakan platina sehingga arus ke massa terputus. Dengan terputusnya arus tersebut, kemagnetan pada solenoid hilang, sehingga armature kembali ke posisi semula. Hal ini menyebabkan platina menutup kembali untuk menghubungkaan arus ke massa. Proses ini berlangsung cepat, dan diafragma membuat armature bergetar lebih cepat lagi, sehingga menghasilkan resonansi suara", visual: "Klakson"),
        
        Part(nama: "Fuse", fungsi: "Fuse atau sering disebut sekering merupakan komponen pengaman pada jaringan kelistrikan, termasuk juga pada jaringan kelistrikan klakson. Fuse berfungsi untuk mencegah terjadinya kerusakan pada komponen lainnya bila terjadi hubungan singkat atau kelebihan tegangan. Fuse akan putus jika terjadi hubungan singkat atau beban arus berlebihan sehingga arus tersebut tidak akan mengalir ke komponen kelistrikan lainnya sehingga komponen kelistrikan lainnya akan aman dari kerusakan.", visual: "Fuse"),
        
        Part(nama: "Saklar Klakson", fungsi: "Pada dasarnya, sistem klakson menggunakan tipe saklar tekan, yaitu ketika saklar ditekan pada terjadi hubungan antara terminal klakson satu dengan yang lainnya. Pada sistem kelistrikan klakson dengan menggunakan pengendali negatif, saklar diletakkan dibagian jaringan negatif yaitu digunakan untuk memutus kan arus terminal 86 yang menuju ke massa atau negatif baterai.", visual: "TombolKlakson"),
        
        Part(nama: "Accu", fungsi: "Baterai (ACCU) pada sistem kelistrikan klakson berfungsi sebagai sumber listrik utama dengan arus DC (Direct Current) atau arus searah. Baterai ini memiliki tegangan sebesar 12 volt dan memiliki dua kutub yaitu positif dan negatif. Bila arus yang ada dibaterai mulai kosong maka akan berdampak pada bunyi klakson yang juga semakin melemah", visual: "Aki"),
        
        Part(nama: "Kunci Kontak", fungsi: "Kunci kontak berfungsi untuk memutuskan dan menghubungkan listrik pada rangkaian atau mematikan dan menghidupkan sistem di rangkaian kelistrikan klakson.", visual: "KunciKontak")
        
    ]
    
    @Published var selectedPart = [Part]()

    func checkButton() -> Bool{
        
        if selectedPart.count == 5 {
            
            return true
            
        }
        return false
    }
    
    func performDrop(info: DropInfo) -> Bool {
        
        // Check if its available
        
        for provider in info.itemProviders(for: [String(kUTTypeURL)]){
            
            print("url loaded")
            
            let _ = provider.loadObject(ofClass: URL.self) { (url,error) in
                
                print(url!)
                
                
                // Adding to selected array...
                
                // checking the array wheter it is already addedd..
                
                let status = self.selectedPart.contains { (check) -> Bool in
                    
                    if check.visual == "\(url!)" {return true}
                    
                    else {return false}
                }
                
                if !status {
                    
                    // Add animation
                    
                    DispatchQueue.main.async {
                        withAnimation(.easeOut){
                            
                            self.selectedPart.append(Part(nama: "\(url!)", fungsi: "", visual: "\(url!)"))
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
        return true
        
        
        
    }
    
}


struct DragDropSimulationViews_Previews : PreviewProvider {
    static var previews: some View {
        DragDropSimulationView(parts: ComponentManager().allComponent.first!.parts)
            
    }
}

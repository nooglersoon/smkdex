//
//  Drag&DropSimulationView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 02/08/21.
//

import SwiftUI
import AVKit

struct DragDropSimulationView: View {
    
    var parts: [Part]
    @State private var isARPresented = false
    @State private var switchPlayed = false
    
    @StateObject var simulationManager = DragDropSimulationManager()
    
    
    let negativeAki = CGPoint(x: 130, y: 165)
    let negativeSekering = CGPoint(x: 260, y: 130)
    let negativeTombol = CGPoint(x: 260, y: 260)
    let negativeKontak = CGPoint(x: 260, y: 390)
    let negativeKlakson = CGPoint(x: 130, y: 425)
    
    
    @State private var pathwayAki = CGPoint(x: 130, y: 105)
    @State private var dragAki = false
    @State private var isAkiTapped = false
    
    @State private var pathwaySekring = CGPoint(x: 260, y: 165)
    @State private var dragSekring = false
    @State private var isSekringTapped = false
    
    @State private var pathwayTombol = CGPoint(x: 260, y: 295)
    @State private var dragTombol = false
    @State private var isTombolTapped = false
    
    @State private var pathwayKontak = CGPoint(x: 260, y: 425)
    @State private var dragKontak = false
    @State private var isKontakTapped = false
    
    @State private var pathwayKlakson = CGPoint(x: 130, y: 390)
    @State private var dragKlakson = false
    @State private var isKlaksonTapped = false
    
    @State var audioPlayer: AVAudioPlayer!
    
    
    
    var body: some View {
        
        
        ZStack {
            
            VStack(spacing:30) {
                
                Spacer()
                
                ZStack {
                    
                    VStack {
                        
                        Text("Rangkaian Klakson")
                            .font(.headline)
                        Text("Sambungkan Rangkaian dari Titik ke Titik!")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                            
                            HStack(alignment: .center) {
                                
                                PartView(part: parts[0])
                                Spacer()
                                PartView(part: parts[1])
                                
                            }
                            
                            HStack(alignment: .center) {
                                
                                Spacer()
                                PartView(part: parts[2])
                                
                            }
                            
                            HStack(alignment: .center) {
                                
                                PartView(part: parts[4])
                                Spacer()
                                PartView(part: parts[3])
                                
                            }
                            
                        }
                        .padding(.horizontal,20)
                        
                    }
                    
                    
                }
                .background(Color(.systemBackground))
                
                
                GeometryReader { _ in
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Coba Rangkaian")
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                            
                        }
                        .padding()
                        
                        
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                            
                            Button(action: {
                                
                                switchPlayed.toggle()
                                
                            }, label: {
                                Rectangle()
                                    .frame(width: 88, height: 88, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(14)
                                    .foregroundColor(switchPlayed ? .red : .green)
                                    .overlay(
                                    
                                        Text(switchPlayed ? "OFF" : "ON")
                                            .bold()
                                            .foregroundColor(.white)
                                        
                                    )
                                    
                            })
                            .opacity(wireIsDone() ? 1 : 0.5)
                            .disabled(wireIsDone() ? false : true)
                            
                            Button(action: {
                                
                                audioPlayer.play()
                                
                            }, label: {
                                Rectangle()
                                    .frame(width: 88, height: 88, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(14)
                                    .foregroundColor(switchPlayed ? .orange : .gray)
                                    .overlay(
                                    
                                        Image(systemName: "speaker.wave.2.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                        
                                    )
                                    
                            })
                            .opacity(switchPlayed && wireIsDone() ? 1 : 0.5)
                            .disabled(switchPlayed  && wireIsDone()  ? false : true)
                            
                            
                        }

                        GoToARButtonView(isARPresented: $isARPresented, actionView: {
                            isARPresented.toggle()
                        }, actionName: "Simulasi Rangkaian pada AR")
                        .padding()
                        .disabled(wireIsDone() ? false : true)
                        .opacity(wireIsDone() ? 1 : 0.5)
                        
                        
                    }

                    
                }
                .frame(width: UIScreen.main.bounds.width, height: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(.systemGray5))
                
                
            }
            
            ZStack {
                
                Group {
                    
                    ZStack {
                        
                        Circle()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.blue)
                            .position(x: 130, y: 130)
                        
                        BulletPositif(position: CGPoint(x: 130, y: 130), pathway: $pathwayAki, isDrag: $dragAki, isTapped: $isSekringTapped, dropPoint: negativeSekering)
                        
                    }
                    
                    ZStack {
                        
                        Circle()
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.red)
                            .position(negativeAki)
                        
                        BulletNegatif(isTapped: $isAkiTapped)
                            .position(negativeAki)
                        
                    }
                    
                    
                    BulletPositif(position: CGPoint(x: 260, y: 165), pathway: $pathwaySekring, isDrag: $dragSekring, isTapped: $isTombolTapped, dropPoint: negativeTombol)
                    
                    BulletNegatif(isTapped: $isSekringTapped)
                        .position(negativeSekering)
                    
                    
                    BulletPositif(position: CGPoint(x: 260, y: 295), pathway: $pathwayTombol, isDrag: $dragTombol, isTapped: $isKontakTapped, dropPoint: negativeKontak)
                    
                    BulletNegatif(isTapped: $isTombolTapped)
                        .position(negativeTombol)
                    
                    
                    BulletPositif(position: CGPoint(x: 260, y: 425), pathway: $pathwayKontak, isDrag: $dragKontak, isTapped: $isKlaksonTapped, dropPoint: negativeKlakson)
                    
                    BulletNegatif(isTapped: $isKontakTapped)
                        .position(negativeKontak)
                    
                    
                    BulletPositif(position: CGPoint(x: 130, y: 390), pathway: $pathwayKlakson, isDrag: $dragKlakson, isTapped: $isAkiTapped, dropPoint: negativeAki)
                    
                    BulletNegatif(isTapped: $isKlaksonTapped)
                        .position(negativeKlakson)
                    
                }
            
            }
            
            
        }
        .fullScreenCover(isPresented: $isARPresented){
            ARSimulationView()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(trailing: Button(action: {
            
            resetWire()
            
        }, label: {
            Text("Reset")
        }))
        
        .onAppear{
            
            let sound = Bundle.main.path(forResource: "horn_sound", ofType: "wav")
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            
        }
        
    }
    
    func resetWire(){
        
        isAkiTapped = false
        dragAki = false
        
        isTombolTapped = false
        dragTombol = false
        
        isKontakTapped = false
        dragKontak = false
        
        isSekringTapped = false
        dragSekring = false
        
        isKlaksonTapped = false
        dragKlakson = false
        
        
    }
    
    func wireIsDone() -> Bool {
        
        if isAkiTapped == true && isTombolTapped == true && isKontakTapped == true && isSekringTapped == true && isKlaksonTapped == true {
            
            return true
            
        }
        
        return false
        
    }
    
}

struct Drag_DropSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        DragDropSimulationView(parts: ComponentManager().allComponent.first!.parts)
            
    }
}

struct PartView : View{
    
    var part: Part
    
    var body: some View {
        
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.systemOrange))
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)), radius: 4, x: 3, y: 3)
                Image(uiImage: UIImage(named: part.visual)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(part.nama)
                .font(.caption2)
            
        }
        
    }
}

class DragDropSimulationManager: ObservableObject {
    
    @Published var wireIsFinished = false
    
    
}

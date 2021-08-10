//
//  ARTroubleShootView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 02/08/21.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation

enum TroubleshootPart {
    
    case tombolKlakson,kunciKontak, klakson, fuse, aki
    
}


struct ARTroubleShootView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var soundIsPlayed = true
    @State private var speakingIsPlayed = false
    @State private var infoIsShowed = false
    
    @StateObject var arManager = ARTroubleShootManager()
    
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Pada bagian ini kamu diminta untuk melakukan pengecekan dan perbaikan pada setiap komponen kelistrikan body motor. jika ingin memulai, dekatkan kamera ke tanda spot merah untuk melakukan identifikasi jenis pengecekan dan perbaikan.")
    
    
    var body: some View {
        
        ZStack {
            
            ARTroubleShootViewContainer(arManager: arManager)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack(alignment: .top) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(.gray))
                            .opacity(0.4)
                            .overlay(Image(systemName: "chevron.left")
                                        .font(.system(size: 20)
                                                .bold())
                                        .foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 20){
                        
                        Button(action: {
                            speakingIsPlayed ? stopSound() : playSound()
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(.gray))
                                .opacity(0.4)
                                .overlay(Image(systemName: speakingIsPlayed ? "speaker.slash.fill":"speaker.wave.2.fill")
                                            .foregroundColor(.white))
                        })
                    }
                }
                
                Spacer()
                
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
            
            VStack{
                
                Spacer()
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .overlay(
                            
                            Text("Dekatkan perangkat ke tanda titik merah untuk mengidentifikasi jenis pengecekan")
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width:250)
                            
                        )
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)

                        .fullScreenCover(isPresented: $arManager.isGameOpen){
            
                            if arManager.selectedPartGame == .tombolKlakson {
            
                                TroubleshootTestView(part: "Tombol Klakson")
            
                            } else {
                                
                                
                                
                            }
            
                        }
            
        }
        .onAppear(perform: {
            infoIsShowed = true
            
            
        })
        .onDisappear(perform: {
            if soundIsPlayed {stopSound()}
        })
        
    }
    
    func playSound(){
        
        speakingIsPlayed = true
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        
    }
    
    func stopSound(){
        
        speakingIsPlayed = false
        synthesizer.stopSpeaking(at: .immediate)
        
    }
    
}




struct ARTroubleShootViewContainer: UIViewRepresentable {
    
    @ObservedObject var arManager : ARTroubleShootManager
    
    
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView()
        arView.addCoaching()
        
        // uiView.scene.anchors.removeAll()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Troubleshot.loadScene1()
        
        
        //        let config = ARWorldTrackingConfiguration()
        //        config.planeDetection = .horizontal
        //        uiView.session.run(config, options: [])
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let scene = uiView.scene.anchors[0] as? Troubleshot.Scene1 {
            
            scene.actions.nexttombolklakson.onAction = reactions(_:)
            
        }
        
    }
    
    
    func reactions(_ entity: Entity?) {
        self.arManager.selectedPartGame = .tombolKlakson
        self.arManager.isGameOpen = true
        print("CHANGEEDDD")
    }
    
    
    
    
}

struct ARTroubleShootView_Previews: PreviewProvider {
    static var previews: some View {
        ARTroubleShootView()
    }
}


class ARTroubleShootManager: ObservableObject {
    
    @Published var isGameOpen: Bool  =  false
    @Published var selectedPartGame: TroubleshootPart = .klakson
    
    
}



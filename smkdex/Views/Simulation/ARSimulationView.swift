//
//  ARSimulationView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 25/07/21.
//

import SwiftUI
import ARKit
import RealityKit


struct ARSimulationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var soundIsPlayed = true
    @State private var speakingIsPlayed = false
    @State private var infoIsShowed = false
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Ini adalah rangkaian klakson. Pada rangkaian ini terdiri dari aki, sekring, tombol klakson, kunci kontak dan klakson. Pada rangkaian ini kabel dihubungkan secara seri pada setiap komponennya. Ketika kunci kontak diposisikan pada keadaan aktif dan tombol klakson ditekan, maka klakson akan mengeluarkan bunyi.")
    
    
    var body: some View {
        
        ZStack {
            
            ARSimulationViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack(alignment: .top) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.arButtonColor)
                            .opacity(0.6)
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
                                .foregroundColor(Color.arButtonColor)
                                .opacity(0.6)
                                .overlay(Image(systemName: speakingIsPlayed ? "speaker.slash.fill":"speaker.wave.2.fill")
                                            .foregroundColor(.white))
                        })
                        .padding(.bottom, 25)
                        
                        ARActionButtonView(buttonLabel: "info.circle.fill", action: {
                            infoIsShowed.toggle()
                            showInfo()
                        })
                        
                    }
                }
                
                Spacer()
                
                if infoIsShowed {
                    
                    withAnimation(.easeIn) {
                        ARSimulationInfoView(title: "Selamat Datang di \nSimulasi Rangkaian Kelistrikan ⚡️", bodyInfo: "Dekatkan iPhone mu dengan object, lalu tekan mulai untuk mendengarkan materi dan visualisasi menggunakan AR!")
                    }
                    
                }
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
        }
        .onAppear(perform: {
            infoIsShowed = true
            showInfo()
            
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
    
    func showInfo(){
        
        DispatchQueue.main.asyncAfter(deadline: .now()+7.5) {
            
            infoIsShowed = false
            
        }
        
    }
    
}

struct ARSimulationViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! RangkaianKlakson.loadSkenario()
        arView.addCoaching()
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        // arView.session.run(config, options: [])
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


struct ARViewContainer_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ARSimulationView()

    }
    
}



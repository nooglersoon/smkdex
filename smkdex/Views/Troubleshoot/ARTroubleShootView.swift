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

struct ARTroubleShootView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var soundIsPlayed = true
    @State private var speakingIsPlayed = false
    @State private var infoIsShowed = false
    @State private var isArClosed = false
    
    @StateObject var arManager = ARTroubleShootManager()
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Masih dalam pengembangan")
    
    
    var body: some View {
        
        ZStack {
            
            ARTroubleShootViewContainer(arView: arManager.arView).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack(alignment: .top) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        arManager.killAR()
                    }, label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(.gray))
                            .opacity(0.4)
                            .overlay(Image(systemName: "arrow.turn.left.down")
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
                                .overlay(Text(speakingIsPlayed ? "Berhenti":"Mulai")
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
                        
                            VStack {
                                
                                HStack {
                                    
                                    Text("Test Klakson")
                                        .foregroundColor(.gray)
                                        .bold()
                                    Spacer()
                                    
                                }
                                .padding()
                                
                                Spacer()
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Rectangle()
                                        .foregroundColor(.orange)
                                        .frame(width: 250, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(15)
                                        .overlay(
                                        
                                            HStack{
                                                Text("Coba Bunyikan")
                                                Image(systemName: "megaphone.fill")
                                            }
                                            .foregroundColor(.white)
                                            
                                        )
                                })
                                .padding(.bottom, 15)
                                
                                Spacer()
                                
                                
                            }
                            
                        )
                    
                    
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
            
            
        }
        .onAppear(perform: {
            infoIsShowed = true
            
            
        })
        .onDisappear(perform: {
            if soundIsPlayed {stopSound()}
            isArClosed.toggle()
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
    
    var arView: ARView
    
    func makeUIView(context: Context) -> ARView {
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! SimulasiKlaksonAR.loadScene()
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

struct ARTroubleShootView_Previews: PreviewProvider {
    static var previews: some View {
        ARTroubleShootView()
    }
}


class ARTroubleShootManager: ObservableObject {
    
    @Published var arView = ARView(frame: .zero)
    
    func killAR(){
        
        print("AR Killed")
        // arView.session.pause()
        arView.removeFromSuperview()
        
    }
    
}

//
//  StoryTellingPartView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 15/07/21.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation

struct SimulationView: View {
    
    @State private var isARPresented = false
    @State private var isImageViewPresented = false
    
    let component: Component
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40){
                
                Image(uiImage: UIImage(named: "rangkaianKlakson")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(20)
                    .onTapGesture {
                        isImageViewPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isImageViewPresented){
                        ImageViewer(image: "rangkaianKlakson")
                    }
                
                    
                    
                
                HStack(alignment: .center, spacing: nil){
                    Text("Deskripsi Rangkaian")
                        .font(.system(size: 15))
                        .bold()
                    Spacer()
                    Text("AR • 3D •")
                        .font(.system(size: 15))
                        .bold()
                    Image(systemName: "line.3.crossed.swirl.circle")
                        .font(.system(size: 15, weight: .bold))
                }
                Text(component.longDesc)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                
                
                
                Spacer()
                
                ARButtonView(isARPresented: $isARPresented, actionView: {
                    isARPresented.toggle()
                }, actionName: "Simulasi Rangkaian")
                
            }
            .fullScreenCover(isPresented: $isARPresented){
                ARSimulationView()
            }
            
        }
        .padding()
        .navigationBarTitle("Rangkaian Kelistrikan", displayMode: .inline)
        
        
    }
    
}

struct ImageViewer: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 1
    
    let image: String
    
    var body: some View {
        
        ZStack{
            
            Color(.systemBackground)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(currentScale+finalScale)
                .gesture(MagnificationGesture()
                            .onChanged({ newScale in
                                currentScale = newScale
                            })
                            .onEnded({ scale in
                                currentScale = 0
                            })
                )
            
            VStack{
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    } , label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 40))
                            .foregroundColor(Color(.systemGray))
                    })
                    
                }
                
                Spacer()
                
            }
            .padding()
            
        }
        .padding()
        
        
    }
    
}

struct ARButtonView: View {
    
    @Binding var isARPresented: Bool
    let actionView: () -> Void
    let actionName: String
    
    var body: some View {
        
        Button(action: actionView, label: {
            Text(actionName)
                .foregroundColor(Color(.white))
                .padding()
        })
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        )
        
    }
    
}

struct ARSimulationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var soundIsPlayed = true
    @State private var speakingIsPlayed = false
    @State private var infoIsShowed = false
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Ini adalah simulasi rangkaian kelistrikan untuk komponen klakson. Rangkaian ini terdiri dari aki, main fuse, kunci kontak, tombol klakson dan klakson. Semua komponen dapat dihubungan menggunakan kabel secara seri dengan aki sumber tegangan nya. Pada bagian bawah terdapat cetakan biru yang menunjukan bagaimana setiap komponen terhubung untuk membunyikan klakson. Untuk bentuk nyata dari setiap komponennya, terletak tepat diatas masing-masing simbol.")
    
    
    var body: some View {
        
        ZStack {
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack(alignment: .top) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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
                        .padding(.bottom, 25)
                        
                        ARActionButton(buttonLabel: "info.circle.fill", action: {
                            infoIsShowed.toggle()
                            showInfo()
                        })
                        
                        ARActionButton(buttonLabel:
                                        soundIsPlayed ? "speaker.wave.2.circle.fill" : "speaker.slash.circle.fill", action: {
                                            soundIsPlayed.toggle()
                                        })
                        
                    }
                }
                
                Spacer()
                
                if infoIsShowed {
                    
                    SimulationInfoView()
                    
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

struct ARActionButton: View {
    
    let buttonLabel: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            Image(systemName: buttonLabel)
                .resizable()
                .frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)), radius: 5, x: 3, y: 3)
        })
        
    }
    
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! SimulasiKlaksonAR.loadScene()
        arView.addCoaching()
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config, options: [])
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


struct SimulationInfoView: View {
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(.systemBackground))
                .frame(height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)), radius: 5, x: 3, y: 3)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                Text("Selamat Datang di \nSimulasi Rangkaian Kelistrikan ⚡️")
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Dekatkan iPhone mu dengan object, lalu tekan mulai untuk mendengarkan materi dan visualisasi menggunakan AR!")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
            })
        }
        .padding()
        
    }
    
}


struct StoryTellingPartView_Previews: PreviewProvider {
    static var previews: some View {
        SimulationView(component: Components().allComponent[0])
    }
}

struct ARViewContainer_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ImageViewer(image: "rangkaianKlakson")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)

    }
    
}

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}

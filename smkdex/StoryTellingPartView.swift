//
//  StoryTellingPartView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 15/07/21.
//

import SwiftUI
import RealityKit

struct StoryTellingPartView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var soundIsPlayed = true
    
    var body: some View {
        
        ZStack {
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
               
                HStack(alignment: .top) {
                    
                    ARActionButton(buttonLabel: "chevron.down.circle.fill", action:{
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                    
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                        
                        ARActionButton(buttonLabel: "info.circle.fill", action: {
                            print("tapped")
                        })
                        
                        ARActionButton(buttonLabel: "arrow.clockwise.circle.fill", action: {
                            print("tapped")
                        })
                        
                        ARActionButton(buttonLabel:
                             soundIsPlayed ? "speaker.wave.2.circle.fill" : "speaker.slash.circle.fill", action: {
                                soundIsPlayed.toggle()
                        })
                        
                    }
                }
                
                Spacer()
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
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
                .foregroundColor(Color(.white))
                .opacity(0.4)
        })
        
    }
    
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}



struct StoryTellingPartView_Previews: PreviewProvider {
    static var previews: some View {
        StoryTellingPartView()
            .preferredColorScheme(.dark)
    }
}

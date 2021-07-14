//
//  ContentView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 10/07/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
//        ARViewContainer().edgesIgnoringSafeArea(.all)
        
        Home()
        
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
struct ARViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

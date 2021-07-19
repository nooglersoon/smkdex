//
//  StoryTellingPartView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 15/07/21.
//

import SwiftUI
import RealityKit

struct SimulationView: View {
    
    @State private var isARPresented = false
    let component: Component
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40){
                
                Image(uiImage: UIImage(named: "rangkaianKlakson")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(20)
                
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
    
    var body: some View {
        
        ZStack {
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
               
                HStack(alignment: .top) {
                    
                    ARActionButton(buttonLabel: "chevron.down.circle.fill", action:{
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 20){
                        
                        Button(action: {
                            print("Reset Tapped")
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(.gray))
                                .opacity(0.15)
                                .overlay(Text("Reset")
                                            .foregroundColor(.white))
                        })
                        .padding(.bottom, 25)
                        
                        ARActionButton(buttonLabel: "info.circle.fill", action: {
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
                .foregroundColor(Color(.gray))
                .opacity(0.15)
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
        SimulationView(component: Components().allComponent[0])
    }
}

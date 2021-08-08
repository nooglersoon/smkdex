//
//  StoryTellingPartView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 15/07/21.
//

import SwiftUI
import AVFoundation

struct SimulationView: View {
    
    @State private var isImageViewPresented = false
    
    let components: Component
    let parts: [Part]
    
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
                    .padding()
                
                
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
                .padding(.horizontal)
                
                Text(components.longDesc)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .padding(.horizontal)
                
                
                
                Spacer()
                
                NavigationLink(
                    destination: DragDropSimulationView(parts: components.parts),
                    label: {
                        ZStack{
                            Text("Simulasi Rangkaian")
                                .foregroundColor(Color(.white))
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.orange)
                        )
                        .padding()
                    })

            }
            
        }
        .navigationBarTitle("Rangkaian", displayMode: .inline)
        
        
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




struct StoryTellingPartView_Previews: PreviewProvider {
    static var previews: some View {
        SimulationView(components: ComponentManager().allComponent[0], parts: ComponentManager().allComponent[0].parts)
    }
}



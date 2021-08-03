//
//  Drag&DropSimulationView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 02/08/21.
//

import SwiftUI

struct Drag_DropSimulationView: View {
    //    var parts : [DragModel] = PartList.Part
    var parts: [Part]
    
    @State private var isARPresented = false
    
    
    @State var componentCoordinate: CGPoint = .zero
    var body: some View {
        VStack{
            
            VStack{
                
                Text("Rangkaian Klakson")
                    .font(.headline)
                Text("Pilih komponen dan letakan di placeholder!")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                HStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray4).opacity(0.3))
                        .frame(width: 68, height: 68)
                }
                
                
            }.frame(width: UIScreen.main.bounds.width, height: 430, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            GeometryReader{ _ in
                VStack(alignment: .center){
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
                                    .gesture(
                                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                            .onChanged({ drag in
                                                self.componentCoordinate = drag.location
                                                print("bergerak")
                                            })
                                            .onEnded({ drag in
                                                
                                            })
                                    )
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
}

struct Drag_DropSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        Drag_DropSimulationView(parts: ComponentManager().allComponent.first!.parts)
    }
}

struct partView : View{
    
    var visuals = ""
    
    var body: some View{
        
        VStack{
            
            Image(visuals)
        }.frame(width: 125, height: 200)
    }
}

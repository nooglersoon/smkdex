//
//  TestingView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 16/07/21.
//

import SwiftUI

struct DragDropSimulationView: View {
   
    @State private var isARPresented = false
    
    var parts: [Part]
    
    var body: some View {
            
            VStack{
                
    //            GoToARButonView(isARPresented: $isARPresented, actionView: {}, actionName: "Simulasi Rangkaian pada AR")
                
                Spacer()
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Select Component")
                            .bold()
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            HStack(alignment: .center, spacing: 5){
                                
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
                                    .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                }
                                
                            }
                            
                        }
                    }
                   
                    
                    GoToARButonView(isARPresented: $isARPresented, actionView: {
                        isARPresented.toggle()
                    }, actionName: "Simulasi Rangkaian pada AR")
                    
                    .padding()
                }
                
                .fullScreenCover(isPresented: $isARPresented){
                    ARSimulationView()
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                print("Reset")
            }, label: {
                Text("Reset")
            }))
            .navigationBarTitle("Circuit Simulation",displayMode: .inline)
   
    }
    
}


struct DragDropSimulationViews_Previews : PreviewProvider {
    static var previews: some View {
        DragDropSimulationView(parts: ComponentManager().allComponent.first!.parts)
            
    }
}

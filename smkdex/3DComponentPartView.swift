//
//  3DComponentPartView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 14/07/21.
//

import SwiftUI
import SceneKit

struct _DComponentPartView: View {
    var body: some View {
        Home()
    }
}


//Home View

struct Home : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var models = [
    Model(id: 0, name: "Klakson", modelName: "Klakson.usdz", details: "blabla"),
    Model(id: 0, name: "Accu", modelName: "Accu.usdz", details: "blabla"),
        Model(id: 0, name: "Fuse", modelName: "Fuse.usdz", details: "Rangga ceunah")
    ]
    
    @State var index = 0
    
    var body: some View{
        
        ZStack {
            
            VStack{
                
                SceneView(scene: SCNScene(named: models[index].modelName), options: [.autoenablesDefaultLighting,.allowsCameraControl])
                    
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height/2)
                ZStack{
                    HStack{
                        Button(action: {
                            withAnimation{
                                if index > 0{
                                    index -= 1
                                }
                            }
                        }, label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 35, weight: .bold))
                                .opacity(index == 0 ? 0.3: 1)
                        })
                        .disabled(index == 0 ? true : false)
                        Spacer(minLength: 0)
                        Button(action: {
                            withAnimation{
                                if index < models.count {
                                    index += 1
                                }
                            }
                        }, label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 35, weight: .bold))
                                .opacity(index == models.count - 1 ? 0.3 : 1)
                        })
                        .disabled(index == models.count - 1 ? true : false)
                    }
                    Text(models[index].name)
                        .font(.system(size: 45, weight: .bold))
                }
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.vertical,30)
                
                //Details
                
                    VStack (alignment: .leading, spacing: 15, content: {
                        Text("About")
                            .font(.title2)
                            .fontWeight(.bold)
                    
                    Text(models[index].details)
                    })
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
         
            VStack(alignment: .leading){
                
                HStack(alignment: .top) {
                    
                    ARActionButton(buttonLabel: "chevron.down.circle.fill", action:{
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
            
        }
        
    }
}

//Data Model

struct Model : Identifiable{
    var id : Int
    var name : String
    var modelName : String
    var details : String
}


struct _DComponentPartView_Previews: PreviewProvider {
    static var previews: some View {
        _DComponentPartView()
    }
}

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

struct _DComponentPartView_Previews: PreviewProvider {
    static var previews: some View {
        _DComponentPartView()
    }
}

//Home View

struct Home : View {
    
    @State var models = [
    Model(id: 0, name: "Klakson", modelName: "Assembly klakson.usdz", details: "blabla")
    ]
    
    @State var index = 0
    
    var body: some View{
        VStack{
            
            (SceneView(scene: SCNScene(named: models[index].modelName), options: [.autoenablesDefaultLighting.allowsCameraControl])
                
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height/2,)
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
                .font(.tittle2)
                .fontWeight(.bold)
                
                Text(models[index].details)
                })
            .padding(.horizontal)
            Spacer(minLength: 0)
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

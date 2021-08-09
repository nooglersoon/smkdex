//
//  TroubleshootingView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 18/07/21.
//

import SwiftUI

struct TroubleshootingView: View {
    @State private var isARPresented = false
    let component: Component
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40){
                HStack(alignment: .center, spacing: nil){
                    Text("Perbaikan")
                        .font(.system(size: 15))
                        .bold()
                    Spacer()
                    
                }
                Text(component.longDesc)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                
                Spacer()
                
                GoToARButtonView(isARPresented: $isARPresented, actionView: {
                    isARPresented.toggle()
                }, actionName: "Mulai Perbaikan")
                
            }
            .fullScreenCover(isPresented: $isARPresented){
                ARTroubleShootView()
            }
            
        }
        .padding()
        .navigationBarTitle("Perbaikan", displayMode: .inline)
        
    }
}

struct TroubleshootingView_Previews: PreviewProvider {
    static var previews: some View {
        TroubleshootingView(component: ComponentManager().allComponent[0])
    }
}

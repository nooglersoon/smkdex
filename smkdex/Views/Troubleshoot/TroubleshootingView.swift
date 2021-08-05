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
                
                GoToARButtonView(isARPresented: $isARPresented, actionView: {
                    isARPresented.toggle()
                }, actionName: "Mulai Troubleshoot")
                
            }
            .fullScreenCover(isPresented: $isARPresented){
                ARTroubleShootView()
            }
            
        }
        .padding()
        .navigationBarTitle("Troubleshooting", displayMode: .inline)
        
    }
}

struct TroubleshootingView_Previews: PreviewProvider {
    static var previews: some View {
        TroubleshootingView(component: ComponentManager().allComponent[0])
    }
}

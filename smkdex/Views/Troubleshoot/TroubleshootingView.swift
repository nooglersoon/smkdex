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
            
            VStack(alignment: .leading, spacing: 10){
                
                    Text("Perbaikan")
                        .font(.system(size: 15))
                        .bold()
                 
                Text("Troubleshooting untuk rangkaian klakson meliputi dua anomali, klakson yang terus menyala dan klakson yang tidak bisa menyala. ")
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

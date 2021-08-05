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
        
        MainMenuView()
            
        
    }
}




#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}
#endif

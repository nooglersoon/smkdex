//
//  ComponentPartDetailView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 16/07/21.
//

import SwiftUI

struct ComponentPartDetailView: View {
    var body: some View {
        
        VStack(spacing: 15){
            
            VStack{
                Text("Sandwich")
                    .font(.title)
                   //Spacer()
            }
            VStack{
                Image("testpic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                
            }
            VStack(alignment: .leading){
                Text("What it is")
                    .font(.headline)
                Text("in publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.")
            }
            VStack(alignment: .leading){
                Text("What it's function")
                    .font(.headline)
                Text("in publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.")
            }
            VStack(alignment: .leading){
                Text("How to install it")
                    .font(.headline)
                Text("in publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.")
            }
        }.padding()
        
    }
}


struct ComponentPartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentPartDetailView()
    }
}


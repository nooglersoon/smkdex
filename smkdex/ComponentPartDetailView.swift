//
//  ComponentPartDetailView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 16/07/21.
//

import SwiftUI

struct ComponentPartDetailView: View {
    var body: some View {
                VStack {
                    Text("Tittle")
                        .font(.system(size: 30, weight: .heavy, design: .default))
                    Image("testpic")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("What it is")
                        .offset(x: -145)
                        .font(.system(size: 15, weight: .heavy, design: .default))
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ")
                        .padding()
                    Text("What it's function in horn electical circuit")
                        .offset(x: -25)
                        .font(.system(size: 15, weight: .heavy, design: .default))
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ")
                        .padding()
                    Text("How to Install it")
                        .offset(x: -120)
                        .font(.system(size: 15, weight: .heavy, design: .default))
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text")
                        .padding()
                }
            }
        }


struct ComponentPartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentPartDetailView()
    }
}


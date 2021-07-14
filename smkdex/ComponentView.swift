//
//  ComponentView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 14/07/21.
//

import SwiftUI

struct ComponentView: View {
    var body: some View {
        
        VStack(alignment: .center) {
            
            VStack {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    
                    Image(systemName: "headphones")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Motorcycle Horn")
                        .font(.system(size: 30))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                    
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .padding(30)
            }
            .padding(.top, 50)
            
            Spacer()
            
            HStack {
                
                ComponentButtonView(menu: "Part", menuLogo: "shippingbox.fill")
                ComponentButtonView(menu: "Electrical Circuit", menuLogo: "lasso")
                ComponentButtonView(menu: "Troubleshoot", menuLogo: "gearshape.fill")
                
            }
            
        }
        .padding(30)
    }
}


struct ComponentButtonView: View {
    
    let menu: String
    let menuLogo: String
    var body: some View {
        
        Button(action: {
            print("\(menu) is selected")
        }, label: {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment:.center, spacing: 10){
                    Image(systemName: "\(menuLogo)")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(.top,10)
                    Text("\(menu)")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
            
        })
        
    }
    
}

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView()
    }
}

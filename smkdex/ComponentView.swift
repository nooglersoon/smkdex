//
//  ComponentView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 14/07/21.
//

import SwiftUI

enum MenuView: String, Identifiable {
    
    case part,electricalCircuit,troubleshoot
    
    var id: String {
        
        return self.rawValue
        
    }
}

struct ComponentView: View {
    
    @State private var isPresented = false
    @State private var activeMenuView: MenuView? = nil
    
    var body: some View {
            
            VStack(alignment: .center) {
                
                VStack {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                        
                        Image(uiImage: UIImage(named: "Klakson") ?? #imageLiteral(resourceName: "imagePlaceHolder"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                    
                    ComponentButtonView(isPresented: $isPresented, actionView: {
                        self.activeMenuView = .part
                        print("hehe")
                    }, menu: "Part", menuLogo: "shippingbox.fill")
                    
                    ComponentButtonView(isPresented: $isPresented, actionView: {
                        self.activeMenuView = .electricalCircuit
                    }, menu: "Electrical Circuit", menuLogo: "lasso")
                    
                    ComponentButtonView(isPresented: $isPresented, actionView: {
                        print("Tapped")
                    }, menu: "Troubleshoot", menuLogo: "gearshape.fill")
                    .disabled(true)
                    .overlay(Color(.white).opacity(0.4))
                    
                    
                }.fullScreenCover(item: $activeMenuView) { activeMenuView in
                    
                    switch activeMenuView {
                    
                    case .part:
                        _DComponentPartView()
                    
                    case .electricalCircuit:
                        StoryTellingPartView()
                    
                    case .troubleshoot:
                        Text("No View Available")
                    }
                    
                }
                
            }
            .padding(30)
        }
}


struct ComponentButtonView: View {
    
    @Binding var isPresented: Bool
    
    let actionView: () -> Void
    let menu: String
    let menuLogo: String
    var body: some View {
        
        Button(action: actionView, label: {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment:.center, spacing: 10){
                    Image(systemName: "\(menuLogo)")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.top,10)
                    Text("\(menu)")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 100, alignment: .center)
                    
                }
                .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                
            }
            
        })
        
    }
    
}

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView()
    }
}

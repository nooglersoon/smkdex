//
//  ComponentView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 14/07/21.
//

import SwiftUI

enum MenuView: String, Identifiable {
    
    case part,simulation,troubleshoot
    
    var id: String {
        
        return self.rawValue
        
    }
}

struct ComponentView: View {
    
    @State private var activeMenu: MenuView? = nil
    var component: Component
    var body: some View {
        
        VStack(alignment: .center) {
            
            VStack {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(.systemGray).opacity(0.2))
                            .frame( height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(uiImage: UIImage(named: component.visual) ?? #imageLiteral(resourceName: "imagePlaceHolder"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                .frame(height: UIScreen.main.bounds.height/4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
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
                }
                .padding(.top, 30)
            }
            .padding(.top, 50)
            
            Spacer()
            
            HStack {
                
                NavigationLink(destination: _DComponentPartView(parts: component.parts)) {
                    ComponentMenuView(menu: "Part", menuLogo: "shippingbox.fill")
                }
                
                NavigationLink(destination: SimulationView(components: component, parts: component.parts)) {
                    ComponentMenuView(menu: "Simulation", menuLogo: "wrench.fill")
                }
                
                NavigationLink(destination: TroubleshootingView(component: component)){
                    ComponentMenuView(menu: "Troubleshoot", menuLogo: "wrench.and.screwdriver.fill")
                }
                
            }
        }
        .navigationBarTitle(component.nama, displayMode: .inline)
        .padding(30)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ComponentMenuView: View {
    
    // let action: () -> Void
    let menu: String
    let menuLogo: String
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(.systemOrange))
            
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
        
        
        
        
    }
    
}

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView(component: ComponentManager().allComponent[0])
            .preferredColorScheme(.dark)
    }
}

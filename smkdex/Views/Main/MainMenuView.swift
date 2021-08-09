//
//  MainMenuView.swift
//  smkdex
//
//  Created by Muhammad Sandilaga on 15/07/21.
//

import SwiftUI

struct MainMenuView: View {
    
    var components = ComponentManager().allComponent
    @State private var search: String = ""
    @State private var isTap: Bool = false
    
    private var threeColumnsGrid = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.background
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack(alignment: .leading, spacing:30){
                    
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        LazyVGrid(columns: threeColumnsGrid,spacing: 10){
                            
                            ForEach(components,id: \.self){ component in
                                
                                if component.parts.isEmpty {
                                    
                                    ZStack {
                                        
                                        PartsCardView(isTap: $isTap, partImage: component.visual, partName: component.nama, partDesc: component.shortDesc)
                                            .disabled(true)
                                            .opacity(0.3)
                                        
                                        Text("Segera Hadir")
                                            .bold()
                                            .foregroundColor(.white)
                                        
                                    }
                                    
                                } else {
                                    
                                    NavigationLink(destination: ComponentView(component: component)){
                                        
                                        PartsCardView(isTap: $isTap, partImage: component.visual, partName: component.nama, partDesc: component.shortDesc)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal,5)
                    
                }
                .navigationBarTitle("Kelistrikan Motor")
                
            }
        }
        
    }
    
}



struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .preferredColorScheme(.light)
    }
}

//Controller radius
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {
        
        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

//Card view carousel
struct PartsCardView: View {
    
    @Binding var isTap: Bool
    
    let partImage: String
    let partName: String
    let partDesc: String
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FFCD18"), Color.init(hex: "FF9F0A")]), startPoint: .top, endPoint: .bottom)
                .frame(width: 180, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .foregroundColor(isTap ? .white : Color(.red))
                .padding(.horizontal,20)
                .padding(.vertical, 10)
                .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)), radius: 5, x: 3, y: 6)
            
            
            VStack(alignment: .center, spacing: 30){
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [.white,Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1))]), center: .center, startRadius: 20, endRadius: 70)
                        .frame(width: 130, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    Image(uiImage: UIImage(named: partImage) ?? #imageLiteral(resourceName: "imagePlaceHolder"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                HStack {
                    
                    Text(partName)
                        .font(.headline)
                        .bold()
                    Spacer()
                }
            }
            .frame(width: 135, height: 205)
            .padding()
            .background(Color.navbar)
            .cornerRadius(18)
            
            
        }
        
        
        
        //
        //        .cornerRadius(20)
        
        
    }
    
}


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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .center, spacing: 30){
                    Spacer()
                    HStack{
                        Text("Motorcycle Parts")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    //                    HStack{
                    //                        Image(systemName: "magnifyingglass")
                    //                        TextField("What do you want to learn?", text: $search)
                    //                    }
                    //                    .padding()
                    //                    .background(Color(.secondarySystemFill))
                    //                    .cornerRadius(20.0)
                }
                .frame(height: 150, alignment: .center)
                .padding()
                .background(Color.navbar)
                //                .cornerRadius(radius: 20, corners: [.bottomLeft, .bottomRight]
                //
                //                )
                .shadow(radius: 20)
                
                VStack(alignment: .leading, spacing:30){
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack (spacing: 20){
                            NavigationLink(destination: ComponentView(component: components[0])){
                                
                                PartsCardView(isTap: $isTap, partImage: components[0].visual, partName: components[0].nama, partDesc: components[0].shortDesc)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
                
                Spacer()
                
            }
            .background(Color.background)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Motorcyle Parts")
            .navigationBarHidden(true)
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
                        .font(.title3)
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


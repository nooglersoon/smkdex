//
//  MainMenuView.swift
//  smkdex
//
//  Created by Muhammad Sandilaga on 15/07/21.
//

import SwiftUI

struct MainMenuView: View {
    
    var components = Models().allComponent
    @State private var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .center, spacing: 30){
                    Spacer()
                    HStack{
                        Text("Welcome Back!")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Image(uiImage: #imageLiteral(resourceName: "imagePlaceHolder"))
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("What do you want to learn?", text: $search)
                    }
                    .padding()
                    .background(Color(.secondarySystemFill))
                    .cornerRadius(20.0)
                }
                .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(radius: 20, corners: [.bottomLeft, .bottomRight]
                )
                
                VStack(alignment: .leading, spacing:30){
                    
                    Text(Categories.electricity.label)
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 20)
                    ScrollView(.vertical, showsIndicators: false){
                            VStack (spacing: 20){
                                NavigationLink(destination: ComponentView(component: components[0])){
                                    
                                    PartsCardView(partImage: components[0].nama, partName: components[0].visual, partDesc: components[0].shortDesc)
                                        .padding(.horizontal, 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                }
                .padding(.vertical, 10)
                
                
                Spacer()
            
            }
    //        .background(Color(.cyan))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
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
    
    let partImage: String
    let partName: String
    let partDesc: String
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading, spacing: 20){
                Text(partName)
                    .font(.subheadline)
                    .bold()
                Text(partDesc)
                    .font(.caption)
            }
            
            Image(uiImage: UIImage(named: partImage) ?? #imageLiteral(resourceName: "imagePlaceHolder"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 102, height: 102, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .frame(height: 150)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        
    }
    
}


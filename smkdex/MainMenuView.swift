//
//  MainMenuView.swift
//  smkdex
//
//  Created by Muhammad Sandilaga on 15/07/21.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var search: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            VStack{
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
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(radius: 20, corners: [.bottomLeft, .bottomRight]
            )
            VStack(alignment: .leading){
                
                Text("Motorcycles Electricity")
                    .font(.title2)
                ScrollView(.horizontal){
                    HStack{
                        PartsCardView()
                        PartsCardView()
                        PartsCardView()

                }

                }
                Spacer()
                
            }
            .padding()
            Spacer()
        
        
        }.background(Color(.cyan))
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
    var body: some View {
        VStack(alignment: .leading){
            Image(uiImage: #imageLiteral(resourceName: "imagePlaceHolder"))
            Text("Motorcycle Horn")
                .font(.subheadline)
            Text("A horn is a sound making device that can be equiped to a motorcycle")
                .font(.caption)
        }
        .frame(width:120
        )
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}

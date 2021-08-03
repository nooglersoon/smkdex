//
//  ARActionButtonView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 02/08/21.
//

import SwiftUI

struct ARActionButtonView: View {
    let buttonLabel: String
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action, label: {
            Image(systemName: buttonLabel)
                .resizable()
                .frame(width: 45, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)), radius: 5, x: 3, y: 3)
        })
        
    }
}

struct ARSimulationInfoView: View {
    
    let title: String
    let bodyInfo: String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(.systemBackground))
                .frame(height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)), radius: 5, x: 3, y: 3)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                Text(title)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(bodyInfo)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
            })
        }
        .padding()
        
    }
    
}

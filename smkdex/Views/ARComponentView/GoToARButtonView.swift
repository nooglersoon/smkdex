//
//  GoToARButtonView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 02/08/21.
//

import SwiftUI

struct GoToARButtonView: View {
    @Binding var isARPresented: Bool
    let actionView: () -> Void
    let actionName: String
    
    var body: some View {
        
        Button(action: actionView, label: {
            Text(actionName)
                .foregroundColor(Color(.white))
                .padding()
        })
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        )
        
    }
}

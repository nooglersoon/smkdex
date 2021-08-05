//
//  TroubleshootTestView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 05/08/21.
//

import SwiftUI

struct TroubleshootTestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let part: String
    var body: some View {
        
        ZStack {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack(alignment: .top) {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(.gray))
                            .opacity(0.4)
                            .overlay(Image(systemName: "arrow.turn.left.down")
                                        .font(.system(size: 20)
                                                .bold())
                                        .foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 20){
                        
                        Button(action: {
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(.gray))
                                .opacity(0.4)
                                .overlay(Image(systemName: true ? "speaker.slash.fill":"speaker.wave.1.fill")
                                            .foregroundColor(.white))
                        })
                    }
                }
                
                Spacer()
                
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
            Text("Ini troubleshooting \(part)")
            
        }
        
        
    }
}

struct TroubleshootTestView_Previews: PreviewProvider {
    static var previews: some View {
        TroubleshootTestView(part: "Tombol Klakson")
    }
}

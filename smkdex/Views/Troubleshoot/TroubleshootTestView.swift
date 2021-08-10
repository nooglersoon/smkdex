//
//  TroubleshootTestView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 05/08/21.
//

import SwiftUI

struct TroubleshootTestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isMisiOpen = false
    
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
                            
                            isMisiOpen.toggle()
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(.gray))
                                .opacity(0.4)
                                .overlay(Text("Petunjuk")
                                            .foregroundColor(.white))
                        })
                    }
                }
                
                Spacer()
                
                
            })
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
           MiniGameTroubleShootView()
            
        }
                    .sheet(isPresented: $isMisiOpen){
                        
                        ZStack {
                            
                            Color.background
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                                
                                Text("Misi")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Text("Periksa sambungan kabel dan perbaiki jika soket lepas dan ada kabel yang putus")
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
        
        
    }
}

struct TroubleshootTestView_Previews: PreviewProvider {
    static var previews: some View {
        TroubleshootTestView(part: "Tombol Klakson")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

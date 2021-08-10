//
//  AlatView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 09/08/21.
//

import SwiftUI

enum SelectedAlat {
    
    case ampelas,obeng,tang
    
}

struct AlatView: View {
    
    var parts: [Alat]
    
    @State var showingNotice = false
    @State var showingX = false
    @State var selectedAlat: SelectedAlat = .ampelas
    
    @Binding var isShowing: Bool
    var body: some View {
            ZStack(alignment: .center){
                if showingNotice{
                    FloatingNotice(showingNotice: $showingNotice)
                }
            }
            .animation(.easeInOut(duration: 1))
            ZStack(alignment: .center){
                if showingX{
                    FloatingX(showingX: $showingX)
                }
            }
            .animation(.easeInOut(duration: 1))
        
        ZStack(alignment: .bottom){
            
            if isShowing{
                VStack(alignment:.leading){
                    Text("Pilih Alat yang Tepat")
                        .foregroundColor(Color.white)
                        .padding(.leading, 20)
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            HStack(alignment: .center){
                                
                                ForEach(parts, id: \.self){ part in
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color(.systemBackground))
                                            .frame(width: 120, height: 120, alignment: .center)
                                            .shadow(color: Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)), radius: 4, x: 3, y: 3)
                                        VStack(spacing: 5){
                                            Image(uiImage: UIImage(named: part.visual)!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            
                                            Text(part.nama)
                                                .font(.system(size: 13))
                                                .bold()
                                            
                                        }
                                        .onTapGesture {
                                            if part.visual == "Amplas"
                                            {
                                                selectedAlat = .ampelas
                                                self.showingNotice = true
                                                print("bisa")
                                            } else if part.visual == "Tang" {
                                                
                                                self.showingX = true
                                                print("tang bisa")
                                            }
                                            else if part.visual == "Obeng" {
                                                self.showingX = true
                                                print("obeng bisa")
                                            }
                                            
                                            
                                            
                                        }
                                    }
                                    .frame(width: 150, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .background(Color.secondary)
                .transition(.move(edge: .bottom)) 
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
        
    }
}

struct AlatView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGameTroubleShootView()
        
    }
}

struct FloatingNotice: View {
    @Binding var showingNotice: Bool

    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            Image(systemName: "checkmark")
                .foregroundColor(.green)
                .font(.system(size: 200, weight: .regular))
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
            Text("Benar")
                .foregroundColor(.white)
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.gray.opacity(0.75))
        .cornerRadius(5)
        .transition(.scale)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.showingNotice = false
            })
        })
    }
}

struct FloatingX: View {
    @Binding var showingX: Bool

    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(.system(size: 200, weight: .regular))
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
            Text("Salah")
                .foregroundColor(.white)
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.gray.opacity(0.75))
        .cornerRadius(5)
        .transition(.scale)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.showingX = false
            })
        })
    }
}

//
//  3DComponentPartView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 14/07/21.
//

import SwiftUI
import SceneKit


//Home View

struct _DComponentPartView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var parts: [Part]
    
    
    @State var index = 0
    
    var body: some View{
        let namedss = "\(parts[index].visual)"
        ZStack {
            
            VStack{
                ZStack{
                Color(.systemBackground)
                    SceneView(scene: {
                        let scene = SCNScene(named: "\(parts[index].visual).usdz")!
                        scene.background.contents = UIColor.systemBackground
                        return scene
                    }(), options: [.autoenablesDefaultLighting,.allowsCameraControl])
                    .overlay(
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
//                                Button(action: {
//                                    withAnimation{
//                                        if index > 0{
//                                            index -= 1
//                                        }
//                                    }
//                                }, label: {
//                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
//                                        .font(.system(size: 30, weight: .bold))
//                                        .opacity(index == 0 ? 0.3: 1)
//                                        .foregroundColor(.black)
//                                })
                                NavigationLink(
                                    destination: PartPopUpView(part: "", nameds: namedss),
                                    label: {
                                        
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(Color(.gray))
                                                .opacity(0.4)
                                            
                                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Color(.white))
                                        }
                                        
                                    })
                                    .padding()
                            }
                            .padding(.horizontal,27)
                        }
                    )
                    .padding(.top, 50)
                }
                .frame(width: UIScreen.main.bounds.width , height: 300)
                
                
                ZStack{
                    HStack{
                        Button(action: {
                            withAnimation{
                                if index > 0{
                                    index -= 1
                                }
                            }
                        }, label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 35, weight: .bold))
                                .opacity(index == 0 ? 0.3: 1)
                        })
                        .disabled(index == 0 ? true : false)
                        Spacer(minLength: 0)
                        Button(action: {
                            withAnimation{
                                if index < parts.count {
                                    index += 1
                                }
                            }
                        }, label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 35, weight: .bold))
                                .opacity(index == parts.count - 1 ? 0.3 : 1)
                        })
                        .disabled(index == parts.count - 1 ? true : false)
                    }
                    Text(parts[index].nama)
                        .font(.system(size: 30, weight: .bold))
                }
                .foregroundColor(Color(.black))
                .padding(.horizontal, 30)
                .padding(.vertical,30)
                
                //Details
                
                    VStack (alignment: .leading, spacing: 15, content: {
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
                    
                        Text(parts[index].fungsi)
                            .font(.system(size: 15))
                    })
                .padding(.horizontal, 30)
                Spacer(minLength: 0)
            }
         
//            VStack(alignment: .leading){
//                
//                HStack(alignment: .top) {
//                    
//                    ARActionButton(buttonLabel: "chevron.down.circle.fill", action:{
//                        presentationMode.wrappedValue.dismiss()
//                    })
//                    
//                    Spacer()
//                    
//                }
//                
//                Spacer()
//                
//            }
            .padding(.top, 50)
            .padding(.horizontal, 30)
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("3D View Part", displayMode: .inline)
    }
}

struct _DComponentPartView_Previews: PreviewProvider {
    static var previews: some View {
        _DComponentPartView(parts: ComponentManager().allComponent[0].parts)
    }
}



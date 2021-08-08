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
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
            node.runAction(repeatForever)
    }
    
    @State var index = 0
    
    var body: some View{
        let namedss = "\(parts[index].visual)"
        ZStack {
            
            VStack{
                ZStack{
                    
                    SceneView(scene: {
                        let scene = SCNScene(named: "\(namedss).usdz")!
                        
                        switch namedss{
                        case "Aki":
                            let action = SCNAction.rotate(by: CGFloat(Float.pi), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
                            let repeatAction = SCNAction.repeatForever(action)
                            scene.rootNode.runAction(repeatAction)
                        case "Klakson":
                            if let node = scene.rootNode.childNodes.first {
                                let action = SCNAction.rotate(by: CGFloat(Float.pi), around: SCNVector3(x: 0, y: 0.1, z: 0), duration: 2)
                                let repeatAction = SCNAction.repeatForever(action)
                                node.runAction(repeatAction)
                            }

                        case "KunciKontak":
                            let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x: 0, y: 0.01, z: 0), duration: 8)
                            let repeatAction = SCNAction.repeatForever(action)
                            scene.rootNode.runAction(repeatAction)
                        case "Fuse":
                            let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x: 0, y: 0.01, z: 0), duration: 8)
                            let repeatAction = SCNAction.repeatForever(action)
                            scene.rootNode.runAction(repeatAction)
                        case "TombolKlakson":
                            let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x: 0, y: 0.01, z: 0), duration: 8)
                            let repeatAction = SCNAction.repeatForever(action)
                            scene.rootNode.runAction(repeatAction)
                        
                        default:
                            break
                        }
                        
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
                .frame(width: UIScreen.main.bounds.width , height: 350)
                
                
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
                                .foregroundColor(.orange)
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
                                .foregroundColor(.orange)
                        })
                        .disabled(index == parts.count - 1 ? true : false)
                    }
                    Text(parts[index].nama)
                        .font(.system(size: 30, weight: .bold))
                        
                }
                .padding(.horizontal, 30)
                .padding(.vertical,30)
                
                //Details
                
                    VStack (alignment: .leading, spacing: 15, content: {
                        HStack(alignment: .center, spacing: nil){
                            Text("Deskripsi Rangkaian")
                                .font(.system(size: 15))
                                .bold()
                            Spacer()
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
        .navigationBarTitle("Tampilan 3D Komponen", displayMode: .inline)
    }
}

struct _DComponentPartView_Previews: PreviewProvider {
    static var previews: some View {
        _DComponentPartView(parts: ComponentManager().allComponent[0].parts)
    }
}



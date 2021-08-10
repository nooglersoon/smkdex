//
//  MiniGameTroubleShootView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 03/08/21.
//

import SwiftUI
import SceneKit


struct MiniGameTroubleShootView: View {
    
    @State var index = 0
    @State var firstCase0 = true
    @State private var showTools = false
    
    @State private var isOneSelected = true
    @State private var hasOneSelected = false
    @State private var isTwoSelected = false
    @State private var hasTwoSelected = false
    @State private var isThreeSelected = false
    @State private var hasThreeSelected = false
    
    var gameInstruction = [
    
        "Cabut kabel yang terhubung pada saklar klakson",
        "Putar saklar klakson untuk melihat lempengan klakson",
        "Bersihkan lempengan sambungan yang terdapat di klakson "
        
    ]
    
    
    var body: some View {
        
        ZStack {
            KlaksonSceneView(index: $index, firstCase0: $firstCase0).ignoresSafeArea()
                .frame(width: 300, height: 300)
            
            VStack {
                
                VStack(spacing:10) {
                    
                    Text(gameInstruction[index])
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack(spacing:30) {
                        
                        NumIndicator(isSelected:$isOneSelected , hasSelected: $hasOneSelected, num: 1)
                        NumIndicator(isSelected: $isTwoSelected, hasSelected: $hasTwoSelected, num: 2)
                        NumIndicator(isSelected: $isThreeSelected, hasSelected: $hasThreeSelected, num: 3)
                        
                    }
                    
                }
                .padding(.top, 100)
                
                Spacer()
                
                
                
            }
            
            
            if index < 2 {
                
                VStack {
                    
                    Spacer()
                    
                    HStack (spacing:30){
                        Button(action: {
                            withAnimation{
                                if index > 0 || index == 0{
                                    index -= 1
                                }
                            }
                            print("Previous")
                            firstCase0 = false
                            
                        }, label: {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.systemOrange))
                                .frame(width: 147, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    
                                    Text("PREV")
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                )
                                .opacity(index == 0 ? 0.3: 1)
                            
                        }).disabled(true)
                        
                        Button(action: {
                            withAnimation{
                                if index >= 0{
                                    index += 1
                                    isOneSelected = false
                                    hasOneSelected = true
                                    isTwoSelected = true
                                }
                            }
                            print("test")
                            if index == 2{
                                showTools = true
                                isTwoSelected = false
                                hasTwoSelected = true
                                isThreeSelected = true
                            }
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.systemOrange))
                                .frame(width: 147, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    
                                    Text("NEXT")
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                )
                                .opacity(index == 2 ? 0.3: 1)
                            
                            
                        })
                    }
                    .foregroundColor(Color(.black))
                    .padding(.horizontal, 30)
                    .padding(.vertical,30)
                    .padding(.bottom,50)
                    
                }
                
            }
            
            AlatView(parts: AlatManager().alatAlat, hasThreeSelected: $hasThreeSelected, isThreeSelected: $isThreeSelected, isShowing: $showTools)
        }
    }
}

struct MiniGameTroubleShootView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGameTroubleShootView()
    }
}

struct KlaksonSceneView: UIViewRepresentable {
    
    @Binding var index: Int
    @Binding var firstCase0: Bool
    
    func makeUIView(context: Context) -> SCNView {
        
        let klaksonView = SCNView(frame: .zero)
        
        let tombolKotorNode = SCNScene(named: "tombolKotor.usdz")!.rootNode.childNode(withName: "tombol_kotor",
                                                                                          recursively: true)!
        
        let soketKlaksonNode = SCNScene(named: "soketKlakson.usdz")!.rootNode.childNode(withName: "soket_klakson",
                                                                                        recursively: true)!
        
        klaksonView.allowsCameraControl = true
        klaksonView.autoenablesDefaultLighting = true
        klaksonView.scene = SCNScene()
        
        tombolKotorNode.position.x = 0
        tombolKotorNode.position.y = 0
        tombolKotorNode.position.z = 0
        tombolKotorNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        
        soketKlaksonNode.position.x = -2
        soketKlaksonNode.position.y = -10
        soketKlaksonNode.position.z = 2
        soketKlaksonNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        
        klaksonView.scene?.rootNode.addChildNode(tombolKotorNode)
        klaksonView.scene?.rootNode.addChildNode(soketKlaksonNode)
        
        return klaksonView
    }
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        
        
        let soketKlaksonNode = uiView.scene?.rootNode.childNode(withName: "soket_klakson", recursively: true)!
        let tombolKotorNode = uiView.scene?.rootNode.childNode(withName: "tombol_kotor", recursively: true)!
        
        switch index {
        case 0:
            
            if firstCase0 == false{
                let action = SCNAction.moveBy(x: 0, y: -10, z: 0, duration: 1)
                let reversed = SCNAction.reversed(action)
                action.timingMode = .easeInEaseOut
                soketKlaksonNode?.runAction(reversed())
            }
            print("case0")
            break
        case 1:
            let action = SCNAction.moveBy(x: 0, y: -10, z: 0, duration: 1)
            action.timingMode = .easeInEaseOut
            soketKlaksonNode?.runAction(action)
            print("case1")
            
            break
        case 2:
            
            let actionFadeout = SCNAction.fadeOut(duration: 1)
            actionFadeout.timingMode = .easeInEaseOut
            soketKlaksonNode?.runAction(actionFadeout)
            
            let actionRotate = SCNAction.rotateBy(x: CGFloat(GLKMathDegreesToRadians(-90)), y: 0, z: 0, duration: 1)
            actionRotate.timingMode = .easeInEaseOut
            tombolKotorNode?.runAction(actionRotate)
            
            print("case2")
            break
        default:
            break
        }
    }
}


struct NumIndicator: View {
    
    @Binding var isSelected: Bool
    @Binding var hasSelected: Bool
    var num: Int
    
    var body: some View {
        
            
            Circle()
                .foregroundColor(hasSelected ? Color(.systemOrange) : Color(.systemGray5))
                .frame(width: isSelected ? 60 : 40 , height: isSelected ? 60 : 40 , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(Text("\(num)").foregroundColor(hasSelected ? .white : .black))

        
    }
}


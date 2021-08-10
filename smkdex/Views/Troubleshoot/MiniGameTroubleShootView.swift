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
    
    var body: some View {
      
        ZStack {
            KlaksonSceneView(index: $index, firstCase0: $firstCase0).ignoresSafeArea()
                .frame(width: 300, height: 300)
            HStack{
                Button(action: {
                    withAnimation{
                        if index > 0 || index == 0{
                            index -= 1
                        }
                    }
                    print("Previous")
                    firstCase0 = false
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 35, weight: .bold))
                        .background(Color(.systemGray4).opacity(0.3))
                        .clipShape(Circle())
                        .opacity(index == 0 ? 0.3: 1)
                        
                }).disabled(true)
                Spacer()
                Button(action: {
                    withAnimation{
                        if index >= 0{
                            index += 1
                        }
                    }
                    print("test")
                    if index == 2{
                        showTools = true
                    }
                    
                }, label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 50, height: 50)
                        .font(.system(size: 35, weight: .bold))
                        .background(Color(.systemGray4).opacity(0.3))
                        .clipShape(Circle())
                        .opacity(index == 2 ? 0.3: 1)
                    
                })
            }.foregroundColor(Color(.black))
            .padding(.horizontal, 30)
            .padding(.vertical,30)
            
            AlatView(parts: AlatManager().alatAlat, isShowing: $showTools)
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
        
        let tombolKlaksonNode = SCNScene(named: "TombolKlakson.usdz")!.rootNode.childNode(withName: "tmb_klakson",
                                                                                          recursively: true)!
        
        let soketKlaksonNode = SCNScene(named: "soketKlakson.usdz")!.rootNode.childNode(withName: "soket_klakson",
                                                                                        recursively: true)!
        
        klaksonView.allowsCameraControl = true
        klaksonView.autoenablesDefaultLighting = true
        klaksonView.scene = SCNScene()
        
        tombolKlaksonNode.position.x = 0
        tombolKlaksonNode.position.y = 0
        tombolKlaksonNode.position.z = 0
        tombolKlaksonNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        
        soketKlaksonNode.position.x = 0
        soketKlaksonNode.position.y = 0
        soketKlaksonNode.position.z = 0
        soketKlaksonNode.scale = SCNVector3(x: 1, y: 1, z: 1)
        
        klaksonView.scene?.rootNode.addChildNode(tombolKlaksonNode)
        klaksonView.scene?.rootNode.addChildNode(soketKlaksonNode)
        
        return klaksonView
    }
    func updateUIView(_ uiView: SCNView, context: Context) {
        
        
        
        let soketKlaksonNode = uiView.scene?.rootNode.childNode(withName: "soket_klakson", recursively: true)!
        let tombolKlaksonNode = uiView.scene?.rootNode.childNode(withName: "tmb_klakson", recursively: true)!
        
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
            tombolKlaksonNode?.runAction(actionRotate)
            
            print("case2")
            break
        default:
            break
        }
    }
}


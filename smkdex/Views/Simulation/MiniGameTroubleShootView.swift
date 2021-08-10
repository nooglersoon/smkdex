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
    
    var body: some View {
//        if let node = scene.rootNode.childNodes.first {
//            let action = SCNAction.rotate(by: CGFloat(Float.pi), around: SCNVector3(x: 0, y: 0.1, z: 0), duration: 2)
//            let repeatAction = SCNAction.repeatForever(action)
//            node.runAction(repeatAction)
//        }
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
                })
                Spacer()
                Button(action: {
//                    if let k = KlaksonSceneView().klaksonView.scene?.rootNode.childNodes.first{
//                        let action = SCNAction.moveBy(x: 0, y: -10, z: 0, duration: 1)
//                        action.timingMode = .easeInEaseOut
//                        k.runAction(action)
//                    if let k = KlaksonSceneView(soketKlaksonNode: miniManager.soketKlaksonNode)
//                    }
                    withAnimation{
                        if index >= 0{
                            index += 1
                        }
                    }
                    print("test")
                    
                    
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
            if firstCase0 == true{
                let action = SCNAction.moveBy(x: 0, y: 5, z: 0, duration: 1)
                action.timingMode = .easeInEaseOut
                soketKlaksonNode?.runAction(action)
            }
            
            
            
            print("case2")
            break
        default:
            break
        }
    }
}


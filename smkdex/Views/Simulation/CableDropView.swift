//
//  CableDropView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 04/08/21.
//

import SwiftUI

struct BulletPositif: View {
    
    var position: CGPoint
    @Binding var pathway: CGPoint
    @Binding var isDrag: Bool
    @Binding var isTapped: Bool
    var dropPoint: CGPoint
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .position(position)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            pathway = value.location
                            isDrag = true
                            isTapped = false
                        })

                        .onEnded({ value in

                            isDrag = false

                            let distance = calculateDistance(p1: value.location, p2: dropPoint)

                            if distance < 20 {

                                pathway = dropPoint
                                isDrag = true
                                isTapped.toggle()
                                
                            }

                        })
                )
            Path { path in
                path.move(to: position)
                path.addLine(to: pathway)
            }
            .stroke(isDrag ? Color.black : Color.clear,lineWidth: 2)
        }
        
    }
    
    func calculateDistance(p1: CGPoint, p2: CGPoint) -> Float {
        
        let x = pow((p1.x - p2.x), 2)
        let y = pow((p1.y - p2.y), 2)
        
        return Float(sqrt(x+y))
        
    }
    
}

struct BulletNegatif: View {
    
    @Binding var isTapped: Bool
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .frame(width: 18, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
            
            Circle()
                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(isTapped ? .green : .black)
            
        }
            
    }
    
}

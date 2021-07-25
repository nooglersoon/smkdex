//
//  SimulationDragDropView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 25/07/21.
//

import SwiftUI
import MobileCoreServices


struct DragAndDrop: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)
    
    @ObservedObject var delegate = ImgData()
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            LazyVGrid(columns: columns, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                
                ForEach(delegate.totalImages){ image in
                    
                    Image(uiImage: UIImage(named: image.image)!)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                    
                        .onDrag{
                            
                            NSItemProvider(item: .some(URL(string: image.image)! as NSSecureCoding) , typeIdentifier: String(kUTTypeURL))
                            
                        }
                    
                }
            }
            .padding(.all)
            
            Spacer()
            
            // Drop Area
            
            ZStack {
                
                if delegate.selectedImages.isEmpty {
                    
                    Text("Drop Images Here")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack {
                        
                        ForEach(delegate.selectedImages, id:\.image){ image in
                            
                            if image.image != ""{
                                
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                    
                                    Image(image.image)
                                        .resizable()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(15)
                                    
                                    // Remove button
                                    
                                    Button(action: {
                                        
                                        withAnimation(.easeOut) {
                                            self.delegate.selectedImages.removeAll {
                                                (check) -> Bool in
                                                
                                                if check.image == image.image {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                                
                                            }
                                        }
                                        
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.black)
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    })
                                    
                                    
                                })
                                
                            }
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                    }
                    
                }
                .padding(.horizontal)
                
            }
            
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top,10)
            
            // if there is no images
            .frame(height: delegate.selectedImages.isEmpty ? 100 : nil)
            
            .contentShape(Rectangle())
            .background(Color.white)
            
            // Drop area which to receive provided data
            
            
            // receiving some data type
            .onDrop(of: [String(kUTTypeURL)], delegate: delegate)
            
            
        }
        
        .background(Color.black.opacity(0.05))
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

class ImgData: ObservableObject, DropDelegate {
    
    @Published var totalImages: [Img] = [
    
        Img(id: 1, image: "img1"),
        Img(id: 2, image: "img2"),
        Img(id: 3, image: "img3"),
        Img(id: 4, image: "img4")
        
    ]
    
    @Published var selectedImages = [Img]()
    
    func performDrop(info: DropInfo) -> Bool {
        
        // Check if its available
        
        for provider in info.itemProviders(for: [String(kUTTypeURL)]){
            
            print("url loaded")
            
            let _ = provider.loadObject(ofClass: URL.self) { (url,error) in
                
                print(url!)
                
                
                // Adding to selected array...
                
                // checking the array wheter it is already addedd..
                
                let status = self.selectedImages.contains { (check) -> Bool in
                    
                    if check.image == "\(url!)" {return true}
                    
                    else {return false}
                }
                
                if !status {
                    
                    // Add animation
                    
                    DispatchQueue.main.async {
                        withAnimation(.easeOut){
                            
                            self.selectedImages.append(Img(id: self.selectedImages.count, image: "\(url!)"))
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
        return true
        
    }
    
}

struct Img: Identifiable {
    
    var id: Int
    var image: String
    
}

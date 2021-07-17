//
//  TestingView.swift
//  smkdex
//
//  Created by Fauzi Achmad B D on 16/07/21.
//

import SwiftUI

struct TestingView: View {
    @State var counters = ["a","b","c"]

    var body: some View {
        NavigationView {
            List {
                ForEach(counters, id: \.self) { counter in
                    NavigationLink(destination: Text(counter)) {
                        Button(action: {
                            print("hehe")
                        }){
                            CounterCell(counter: counter)
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .listStyle(GroupedListStyle())
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    struct CounterCell: View {

    @State var counter: String
    @State var inc = 0

    var body: some View {
        HStack {
            Button(action: { self.inc += 1 }) {
                Text("plus")
            }
            Button(action: { self.inc -= 1 }) {
                Text("minus")
            }
            Text(" counter: \(counter) value: \(inc)")
        }
    }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}

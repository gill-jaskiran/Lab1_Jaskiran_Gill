//
//  ContentView.swift
//  Lab1_Jaskiran_Gill
//
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            Text("Prime Game") // Added Title
                .font(.largeTitle) // Added UI
                .foregroundColor(.pink)
                .padding(.top, 40)
            Text("Is this a Prime Number?")
                            .font(.title)
                            .padding(.top, 10)
            Text("\(currentNumber)") //a adding the heading and UI
                       .font(.system(size: 90, weight: .bold))
                       .padding(.bottom, 20)
        }
    }
}

#Preview {
    ContentView()
}

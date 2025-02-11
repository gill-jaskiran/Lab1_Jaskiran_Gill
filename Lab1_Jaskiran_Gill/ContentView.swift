//
//  ContentView.swift
//  Lab1_Jaskiran_Gill
//
//

import SwiftUI
@State private var currentNumber = Int.random(in: 1...100) 
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Prime Game") // Added Title
                .font(.largeTitle) // Added UI
                .foregroundColor(.pink)
                .padding(.top, 40)
        }
    }
}

#Preview {
    ContentView()
}

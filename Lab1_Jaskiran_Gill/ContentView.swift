//
//  ContentView.swift
//  Lab1_Jaskiran_Gill
//
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber = Int.random(in: 1...100)
    @State private var numOfCorrectAnswers = 0
    @State private var numOfWrongAnswers = 0
    @State private var numOfAttempts = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text("Prime Game") // Added Title
                .font(.largeTitle) // Added UI
                .foregroundColor(.pink)
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .top)
            Text("Is this a Prime Number?")
                .font(.title)
                .padding(.top, 10)
            Text("\(currentNumber)") //a adding the heading and UI
                .font(.system(size: 90, weight: .bold))
                .padding(.bottom, 0)
            
            }
            
        }
        
        func startTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                numOfWrongAnswers += 1
                numOfAttempts += 1
            }
        }
    }
#Preview {
    ContentView()
}

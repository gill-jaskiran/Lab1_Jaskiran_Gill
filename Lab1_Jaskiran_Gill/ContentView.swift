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
@State private var isResultDisplayed = false
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
        Text("\(currentNumber)") //adding the heading and UI
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

func checkAnswer(isPrimeSelected: Bool) {
    timer?.invalidate()
    
    let isPrime = isPrimeNumber(currentNumber)
    if isPrimeSelected == isPrime {
        numOfCorrectAnswers += 1
    } else {
        numOfWrongAnswers += 1
    }
    
    numOfAttempts += 1
    
    if numOfAttempts % 10 == 0 {
        isResultDisplayed = true
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        updateGame()
    }
}

func updateGame() {
    currentNumber = Int.random(in: 1...100)
    startTimer()
}

func isPrimeNumber(_ num: Int) -> Bool {
    if num < 2 { return false }
    for i in 2..<num {
        if num % i == 0 { return false }
    }
    return true
}
}
#Preview {
ContentView()
}

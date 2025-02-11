//
//  ContentView.swift
//  Lab1_Jaskiran_Gill
//
import SwiftUI

struct ContentView: View {
    @State private var currentNumber = Int.random(in: 1...100)
    @State private var numOfCorrectAnswers = 0
    @State private var numOfWrongAnswers = 0
    @State private var statusIcon: String? = nil
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
            VStack {
                Button(action: {
                    checkAnswer(isPrimeSelected: true)
                }) {
                    Text("Yes - Prime")
                        .font(.title)
                        .padding()
                        .frame(width: 340, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    checkAnswer(isPrimeSelected: false)
                }) {
                    Text("No - Not Prime")
                        .font(.title)
                        .padding()
                        .frame(width: 340.0, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            
            if let imageName = statusIcon {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 10)
            }
        }
        .onAppear {
            startTimer()
        }
        .alert(isPresented: $isResultDisplayed) {
            Alert(
                title: Text("Results"),
                message: Text("Total Correct: \(numOfCorrectAnswers)\nTotal Wrong: \(numOfWrongAnswers)"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            numOfWrongAnswers += 1
            numOfAttempts += 1
            updateGame()
        }
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        timer?.invalidate()
        
        let isPrime = isPrimeNumber(currentNumber)
        if isPrimeSelected == isPrime {
            statusIcon = "checkmark"
            numOfCorrectAnswers += 1
        } else {
            statusIcon = "xmark"
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
        statusIcon = nil
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

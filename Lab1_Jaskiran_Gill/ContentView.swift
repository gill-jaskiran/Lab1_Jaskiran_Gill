//
//  ContentView.swift
//  Lab1_Jaskiran_Gill
//
import SwiftUI

struct ContentView: View {
    // State variables
    @State private var currentNumber = Int.random(in: 1...100) // Generating random number in range 1-100
    @State private var numOfCorrectAnswers = 0 // logging correct answer
    @State private var numOfWrongAnswers = 0 // logging wrong answer
    @State private var statusIcon: String? = nil // storing icon name for feedback to user
    @State private var numOfAttempts = 0 // tacking attempts
    @State private var isResultDisplayed = false // for when alert will be displayed
    @State private var timer: Timer? // initializing the timer
    
    var body: some View {
        VStack {
            Text("Prime Game") // Added Title
                .font(.largeTitle) // Added UI
                .foregroundColor(.pink)
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .top) // centering to the top
            Text("Is this a Prime Number?") // adding subheading - the question
                .font(.title)
                .padding(.top, 10)
            Spacer() // adding spacer so it looks more organied
            Text("\(currentNumber)") //adding the heading and UI
                .font(.system(size: 90, weight: .bold))
                .padding(.bottom, 0)
            VStack {
                Button(action: { // creating the buttons
                    checkAnswer(isPrimeSelected: true) // calls the function when yes button is clicked
                }) {
                    Text("Yes - Prime") // adding text and UI for yes button
                        .font(.title)
                        .padding()
                        .frame(width: 340, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    checkAnswer(isPrimeSelected: false) // Calling the function if the no button is clicked
                }) {
                    Text("No - Not Prime") // adding text and UI for No button
                        .font(.title)
                        .padding()
                        .frame(width: 340.0, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            
            if let imageName = statusIcon { // This will display the status icon
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                // if correct the icon is green, if incorrect icon displayed in red
                    .foregroundColor(imageName == "checkmark" ? .green : .red)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .onAppear {
            startTimer() // timer activated on appear
        }
        .alert(isPresented: $isResultDisplayed) { // results are shown as a alert
            Alert(
                title: Text("Results"), // adding UI for the alert
                message: Text("Total Correct: \(numOfCorrectAnswers)\nTotal Wrong: \(numOfWrongAnswers)"),
                dismissButton: .default(Text("OK")){
                    resetGame() // reseting game after alert
                }
            )
        }
    }
    
    func resetGame() {
        numOfCorrectAnswers = 0
        numOfWrongAnswers = 0
        numOfAttempts = 0
        updateGame()
        startTimer() // timer is restarted after alert dismissed
    }

    func startTimer() {
        timer?.invalidate() // invalidates the timer
        // starts timer - 5 seconds
        if isResultDisplayed { return } // prevent timer continuation on alert
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            numOfWrongAnswers += 1 // increases count for wrong answer if answer is wrong
            numOfAttempts += 1 // increases count for correct answer if answer is wrong
            updateGame() // moves on to the nect integer
        }
    }
    
    func checkAnswer(isPrimeSelected: Bool) {
        timer?.invalidate() // stops the timer
        
        let isPrime = isPrimeNumber(currentNumber) // checks if integer is prime
        if isPrimeSelected == isPrime { // if prime and user selects prime, increases correct count
            statusIcon = "checkmark"
            numOfCorrectAnswers += 1
        } else {
            statusIcon = "xmark" // else if wrong answer displays xmark and increases wrong count
            numOfWrongAnswers += 1
        }
        
        numOfAttempts += 1 // updating number of attempts
        
        if numOfAttempts % 10 == 0 { // showing alert after 10 attempts
            isResultDisplayed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // wait a moment before displaying another number to user
            updateGame()
        }
    }
    
    func updateGame() { // updates the game
        currentNumber = Int.random(in: 1...100) // creates a new number
        statusIcon = nil // clears icon
        startTimer()// timer restarts when new number is displayed
    }
    
    func isPrimeNumber(_ num: Int) -> Bool { // mathmatical functionality - logic
        if num < 2 { return false } // if integer is less than 2 = not prime
        for i in 2..<num { // looping
            if num % i == 0 { return false }// if integer is divisable = not prime
        }
        return true // if integer is not divisable by any integer = prime
    }
}
#Preview {
    ContentView()
}

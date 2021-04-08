//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex Andrei on 05.04.2021.
// (red: 232, green: 224, blue: 204)

import SwiftUI

struct ContentView: View {
    @State private var choices = ["✊", "✋", "✌️"]
    @State private var roundChoice = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random()
    @State private var round = 0
    @State private var score = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color(red: 237 / 255, green: 231 / 255, blue: 216 / 255).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Score \(score)")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 25))
                    .foregroundColor(.black)
                Text("Rounds \(round)/10")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 25))
                    .foregroundColor(.black)
                Spacer()
                    .frame(height: 40)
                Text(choices[roundChoice])
                    .font(.system(size: 125))
                Spacer()
                    .frame(height: 45)
                if shouldWin == true {
                Text("Win this round")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 30))
                    .foregroundColor(.green)
                } else {
                Text("Lose this round")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 30))
                    .foregroundColor(.red)
                }
                Spacer()
                    .frame(height: 33)
                HStack (spacing: 38) {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Text("\(self.choices[number])")
                                .font(.system(size: 65))
                        }
                    }
                }
            }
        }
        .alert (isPresented: $showAlert) {
            Alert(title: Text("\(alertTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Replay")) {
                self.resetGame()
            })
        }
    }
    
    func buttonTapped (_ number: Int) {
        if shouldWin == true {
                if number == 0 && roundChoice == 2 {
                    // rock - scissors
                    score += 1
                    round += 1
                } else if number == 1 && roundChoice == 0 {
                    // paper - rock
                    score += 1
                    round += 1
                } else if  number == 2 && roundChoice == 1 {
                    // scissors - paper
                    score += 1
                    round += 1
                } else {
                    score -= 1
                    round += 1
                }
        } else {
                if (number == 1 || number == 2) && roundChoice == 2 {
                    // rock - scissors
                    score += 1
                    round += 1
                } else if (number == 0 || number == 2) && roundChoice == 0 {
                    // paper - rock
                    score += 1
                    round += 1
                } else if  (number == 0 || number == 1) && roundChoice == 1 {
                    // scissors - paper
                    score += 1
                    round += 1
                } else {
                    score -= 1
                    round += 1
                }
        }
        self.askQuestion()
    }
    
    func askQuestion() {
        if round == 10 {
            alertTitle = "Match ended"
            alertMessage = "Your score is \(score)"
            self.showAlert = true
        } else {
        roundChoice = Int.random(in: 0 ... 2)
        shouldWin = Bool.random()
        }
    }
    
    func resetGame() {
        score = 0
        round = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

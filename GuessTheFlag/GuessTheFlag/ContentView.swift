//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Andrei on 04.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var scoreMessage: String = ""
    @State private var score: Int = 0
    
    @State private var rotate: [Double] = [0.0, 0.0, 0.0]
    @State private var opacity: [Double] = [1.0, 1.0, 1.0]
    @State private var backgroundWrong: Double = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.black]), startPoint: .top, endPoint: .bottom)
                            .opacity(backgroundWrong)
                )
                .edgesIgnoringSafeArea(.all)
                .animation(.default)
            
            VStack (spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(
                        .degrees(self.rotate[number]),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                    .opacity(self.opacity[number])
                    .animation(.default)
                    
                }
 
                Text ("Current score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
            rotate[number] += 360
            for wrongFlags in 0 ..< 3 where wrongFlags != correctAnswer {
                opacity[wrongFlags] = 0.25
            }
        } else {
            if score <= 0 {
            // Do nothing
            } else {
                score -= 1
            }
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
            backgroundWrong = 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacity = [1.0, 1.0, 1.0]
        backgroundWrong = 0
    }
}

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

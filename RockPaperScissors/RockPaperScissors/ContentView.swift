//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex Andrei on 05.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var choices = ["✊", "✋", "✌️"]
    @State private var currentChoice = Int.random(in: 0 ... 2)
    @State private var roundPrompt = Bool.random()
    @State private var round = 0
    @State private var score = 0
    
    var body: some View {
        ZStack {
            Color(red: 232, green: 224, blue: 204, opacity: 100).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Score \(score)")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 25))
                    .foregroundColor(.black)
                Spacer()
                    .frame(height: 50)

                Text(choices[currentChoice])
                    .font(.system(size: 90))
                Spacer()
                    .frame(height: 30)
                if roundPrompt == true {
                Text("WIN")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 30))
                    .foregroundColor(.black)
                } else {
                Text("LOSE")
                    .font(Font.custom("SF Pro Rounded Heavy", size: 30))
                    .foregroundColor(.black)
                }
                Spacer()
                    .frame(height: 50)
                HStack{
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Spacer()
                                .frame(width:20)
                            Text("\(self.choices[number])")
                                .font(.system(size: 75))
                            Spacer()
                                .frame(width:20)
                        }
                    }
                }
            }
        }
    }
    
    func buttonTapped (_ number: Int) {
        if number != currentChoice && roundPrompt == false {
            score += 1
            round += 1
        } else {
            round += 1
        }
        self.askQuestion()
    }
    
    func askQuestion() {
        choices.shuffle()
        currentChoice = Int.random(in: 0 ... 2)
        roundPrompt = Bool.random()
    }
}

/*
struct choiceButton: View {
    let choice: String
    
    var body: some View {
        Button("\(choice)", action: self.buttonTapped(choice))
    }
    
    func buttonTapped(_ choice: Int) {
        if choice == currentChoice {
            
        } else {
            
        }
    }
}
*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

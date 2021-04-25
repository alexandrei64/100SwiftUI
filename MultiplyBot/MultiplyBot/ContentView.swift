//
//  ContentView.swift
//  MultiplyBot
//
//  Created by Alex Andrei on 15.04.2021.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        SettingScreen()
    }
}

struct Question {
    var problem: String
    var answer: String
}

struct SettingScreen: View {
    let questionAlternatives: [String] = ["5", "10", "20", "All"]
    
    @State private var numberOfTables = 1
    @State private var questionSelection = 1
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 208/255, green: 239/255, blue: 251/255).edgesIgnoringSafeArea(.all)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: 370, height: 200, alignment: .center)
                    
                VStack {
                    Image("platformChar_happy")
                        .resizable()
                        .frame(width: 130, height: 130, alignment: .center)
                    
                    Spacer()
                    
                    Group {
                        Stepper(value: $numberOfTables, in: 1...12) {
                            Text("Tables up to: \(numberOfTables)")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        
                        Section(header:
                                Text("Number of questions")
                                    .font(.title2)
                                    .fontWeight(.bold)
                        ) {
                            Picker(selection: $questionSelection, label: Text("Number of Questions"), content: {
                                ForEach(0 ..< questionAlternatives.count) {
                                    Text("\(questionAlternatives[$0])")
                                }
                            })
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .frame(width: 320, height: 50, alignment: .leading)
                    
                    Spacer()
      
                    NavigationLink(
                        destination: GameScreen(tablesReturned: numberOfTables, questionsReturned: questionSelection),
                        label: {
                            Text("start")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        })
                    .padding(45)
                    .background(Color(red: 47/255, green: 190/255, blue: 120/255))
                    .clipShape(Circle())
                    
                }
            }
            .navigationTitle("MultiplyBot")
        }
        .preferredColorScheme(.light)
    }
}

struct GameScreen: View {
    
    var tablesReturned: Int
    var questionsReturned: Int
    
    @State private var character = "platformChar_idle"
    @State private var animateButton: CGFloat = 8
    @State private var correctResult: Int = 0
    @State private var typedResult = ""
    @State private var score: Int = 0
    @State private var round: Int = 0
    @State private var currentQuestion: Int = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color(red: 208/255, green: 239/255, blue: 251/255)
                    .edgesIgnoringSafeArea(.top)
                
                Color(red: 47/255, green: 190/255, blue: 120/255)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            Image("backgroundColorGrass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:390, height: 390, alignment: .center)
                .position(x: 195, y: 270)
            
            Image(character)
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .position(x: 90, y: 310)
            
            VStack {
                Spacer()
                    .frame(height: 30)
                
                Text("what's")
                    .font(.system(size: 30))
                
                Text("")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 40)
                
                TextField("type result", text: $typedResult)
                    .keyboardType(.numberPad)
                    .padding()
                    .font(.system(size: 20))
                    .frame(width: 130, height: 70, alignment: .center)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                    .frame(height: 120)
                
                Button(action: {
                    // check result
                }, label: {
                    Text("check")
                        .fontWeight(.bold)

                    
                })
                .frame(width: 80, height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(Color(red: 242 / 255, green: 103 / 255, blue: 59 / 255))
                .overlay(Capsule().stroke(Color(red: 98 / 255, green: 98 / 255, blue: 98 / 255), lineWidth: animateButton))
                .clipShape(Capsule())
                .position(x: 320, y: 10)
                .animation(.easeInOut)
                
                Spacer()
            }
        }
        .onAppear(perform: { createQuestions(for: tablesReturned) })
        .preferredColorScheme(.light)
    }

    func createQuestions(for a: Int) -> [Question] {
        var problem: String
        var result: String
        var questions = [Question]()
        
        for i in 1...12 {
            problem = "\(a) x \(i)"
            result = "\(a * i)"
            questions.append(Question(problem: problem, answer: result))
        }
        return questions
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

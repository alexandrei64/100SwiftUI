//
//  ContentView.swift
//  MultiplyBot
//
//  Created by Alex Andrei on 14.04.2021.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        SettingScreen()
    }
}


struct SettingScreen: View {
    
    let questionAlternatives: [String] = ["5", "10", "20", "All"]
    
    @State private var numberOfTables = 1
    @State private var questionSelection = 1
 //   @ObservedObject private var startGame = ScreenToggle()
    
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
                        destination: GameScreen(numQ: "1"),
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
    var numQ: String
    
    @State private var character = "platformChar_happy"
    
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
                .rotationEffect(.degrees(-2))
            
            VStack {
                Spacer()
                    .frame(height: 70)
                
                Text("\(numQ) x 8")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

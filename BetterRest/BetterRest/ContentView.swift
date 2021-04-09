//
//  ContentView.swift
//  BetterRest
//
//  Created by Alex Andrei on 07.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView { 
            Form {
                
                Section (header: Text("When do you want to wake up?")) {
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section (header: Text("Desired amount of sleep")) {
                    
                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section (header: Text("Daily coffe intake")) {
                    
                    Stepper(value: $coffeeAmount, in: 1 ... 20) {
                        if coffeeAmount == 1{
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                    
                    // Commented code represents the solution to challenge 2, but a Stepper was a better design
                    
                    /*
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1 ... 20, id: \.self) {
                            if $0 == 1  {
                                Text("\($0) cup")
                            } else {
                                Text("\($0) cups")
                            }
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    */
                }
                
                Section (header: Text("Your ideal bedtime is")) {
                    Text("\(calculateBedtime())")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .preferredColorScheme(.dark)
            .navigationBarTitle(Text("BetterRest"))
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var bedtimePrediction: String = ""

        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
             bedtimePrediction = formatter.string(from: sleepTime)
        } catch {
            bedtimePrediction = "Oops! I encountered an error 🤭"
        }
        return bedtimePrediction
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

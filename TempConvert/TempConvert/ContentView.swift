//
//  ContentView.swift
//  TempConvert
//
//  Created by Alex Andrei on 04.04.2021.
//

import SwiftUI

struct ContentView: View {
    
// Conversion logic
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    @State private var inputAmount = ""
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 1
    
    var outputAmount: Double {

        let inputNumber = Double(inputAmount) ?? 0
        var normalizedNumber: Double = 0
        var outputNumber: Double = 0
        
        // Normalize input
        switch units[selectedInputUnit] {
        case "Fahrenheit":
            // Convert F to C
            normalizedNumber = (inputNumber - 32) * 5/9
        case "Kelvin":
            // Convert K to C
            normalizedNumber = inputNumber - 273.15
        default:
            // Convert C to C, as C is always default selection
            normalizedNumber = inputNumber
        }
        
        // Define output
        switch units[selectedOutputUnit] {
        case "Celsius":
            // Convert C to C
            outputNumber = normalizedNumber
        case "Kelvin":
            // Convert C to K
            outputNumber = normalizedNumber + 273.15
        default:
            // Convert C to F, as F is always default selection
            outputNumber = (normalizedNumber * 9/5) + 32
        }
        // Return converted amount
        return outputNumber
    }

// VIEW CREATION
    
    var body: some View {
        
        NavigationView{
            Form{
                
// Input amount
                
                Section (header: Text("Input temperature")) {
                    TextField("Input amount", text: $inputAmount).keyboardType(.decimalPad)
                }
                
// Input unit selection
                
                Section (header: Text("Choose input unit")) {
                    Picker("Input unit", selection: $selectedInputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
// Output unit selection
                
                Section (header: Text("Choose output unit")) {
                    Picker("Output unit", selection: $selectedOutputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
// Output amount section
                
                Section (header: Text("Your \(units[selectedOutputUnit]) temperature is")) {
                    Text("\(outputAmount, specifier: "%.2f")°")
                }
            }
            .navigationBarTitle("TempConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

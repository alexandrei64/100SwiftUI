//
//  ContentView.swift
//  UnitConverter
//
//  Created by Alex Andrei on 03.04.2021.
// C + 273.12  = K
// (C * 1.8) + 32 = F

import SwiftUI

struct ContentView: View {
    
    @State private var inputAmount = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var outputAmount: Double {
        return 0
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                
// Input amount
                
                Section (header: Text("Input temperature")) {
                    TextField("Input amount", text: $inputAmount).keyboardType(.decimalPad)
                }
                
// Input unit selection
                
                Section (header: Text("Choose input unit")) {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

// Output unit selection
                
                Section (header: Text("Choose output unit")) {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
// Output amount
                
                Section (header: Text("Output temperature")) {
                    Text("\(outputAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

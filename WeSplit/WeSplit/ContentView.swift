//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Andrei on 02.04.2021.
//

import SwiftUI

struct ContentView: View {
// 2  @State private var tapCount = 0
// 3  @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {

/* // 1
        NavigationView {
            Form {
                Section {
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                }
                Section {
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                Text("Hello, world!")
                }
            }
            .navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
        }
*/

/* // 2
        Button("Tap Count \(tapCount)") {
            self.tapCount += 1
        }
*/
        
/* // 3
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello, your name is \(name)")
        }
*/

/*
        Form {
            ForEach(0..<100) {
                Text("Row \($0)")
            }
        }
*/
        Picker("Select your student", selection: $selectedStudent) {
            ForEach(0 ..< students.count) {
                Text(self.students[$0])
            }
        }
  

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

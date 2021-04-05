//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alex Andrei on 04.04.2021.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
 
struct ContentView: View {
    var body: some View {
            VStack{
            Text("Prominent title")
                .titleStyle()
            Text("or just a custom modifier with an extension")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

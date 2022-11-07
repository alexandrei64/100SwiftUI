//
//  AstronautView.swift
//  Moonshot
//
//  Created by Alex Andrei on 26.04.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    //  Challenge 2 ForEach self.mission -- make horizontal scroll view with missions (flight patch + name at bottom)
               /*     ScrollView(.horizontal) {
                        ForEach(self.missions) { mission in
                            MissionListRow(mission: mission, showingNames: false)
                        }
                    }*/
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        let matches = missions.filter { mission in
            mission.crew.contains(where: { $0.name == astronaut.id })
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}

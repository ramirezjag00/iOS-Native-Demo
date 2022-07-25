//
//  ContentView.swift
//  Moonshot
//
//  Created by Andrey Ramirez on 7/23/22.
//

import SwiftUI

struct CustomLayout: View {
    let isGrid: Bool
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        if isGrid {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        } else {
            List {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.trailing)
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isGrid: Bool = true

    var body: some View {
        NavigationView {
            CustomLayout(isGrid: isGrid, missions: missions, astronauts: astronauts)
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Toggle("Grid", isOn: $isGrid)
                    .toggleStyle(SwitchToggleStyle(tint: .red.opacity(0.5)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

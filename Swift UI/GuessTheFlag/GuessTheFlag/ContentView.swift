//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrey Ramirez on 7/16/22.
//

import SwiftUI

struct FlagImage: View {
    var shouldShake: Bool
    var imageTitle: String

    var body: some View {
        Image(imageTitle)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .offset(x: shouldShake ? 30 : 0)
    }
}

struct ContentView: View {
    @State private var shouldReset = false
    @State private var startAnimation: Bool = false
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",
                     "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
                    .shuffled()
    @State private var activeCountry = 0
    
    @State private var shuffledChoices: [String] = []
    
    func getChoices() {
        var filteredChoices = [countries[activeCountry]]
        var filteredCountries = countries.map({ $0 }).shuffled()
        filteredCountries.forEach { country in
            if filteredChoices.count != 3 && !filteredChoices.contains(country) {
                filteredChoices.append(country)
                filteredCountries.remove(at: filteredCountries.firstIndex(of: country)!)
            }
        }

        shuffledChoices = filteredChoices.shuffled()
    }

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                .overlay(Color.black.opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.black))
                    .foregroundColor(.white)
                VStack (spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[activeCountry])
                            .font(.largeTitle.weight(.black))
                            .italic()
                    }
                        
                    
                    ForEach(shuffledChoices, id: \.self) { country in
                        Button {
                            flagTapped(country)
                        } label: {
                            FlagImage(shouldShake: startAnimation && country == countries[activeCountry], imageTitle: countries[countries.firstIndex(of: country)!])
                        }
                    }
                    
                    Text("\(activeCountry + 1) out of 11")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)
                }
                .padding(50)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
        }
        .alert(K.getScoreComment(score), isPresented: $shouldReset) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score is \(score)/\(countries.count)")
        }
        .onAppear(perform: {
            getChoices()
        })
        .onChange(of: activeCountry) { _ in
            getChoices()
        }
    }
    
    func updateQuestion() {
        if activeCountry == countries.count - 1 {
            shouldReset = true
        } else {
            activeCountry += 1
        }
    }
    
    func flagTapped(_ country: String) {
        if country == countries[activeCountry] {
            score += 1
            updateQuestion()
        } else {
            startAnimation.toggle()
            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                startAnimation.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                updateQuestion()
            }
        }
    }
    
    func reset() {
        countries.shuffle()
        activeCountry = 0
        score = 0
        shouldReset = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

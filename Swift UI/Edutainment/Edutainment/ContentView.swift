//
//  ContentView.swift
//  Edutainment
//
//  Created by Andrey Ramirez on 7/20/22.
//

import SwiftUI

extension Color {
    static let offOrangeWhite = Color(red: 245 / 255, green: 226 / 255, blue: 213/255, opacity: 1)
    static let offOrangeWhiteDark = Color(red: 171 / 255, green: 153 / 255, blue: 129/255, opacity: 1)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct ToggleNeumorphic<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        if isHighlighted {
            ZStack {
                shape
                    .foregroundColor(Color.offOrangeWhiteDark)
                    .blur(radius: 4)
                    .offset(x: -14, y: -8)
                shape
                    .foregroundColor(Color.white.opacity(0.5))
                    .blur(radius: 4)
                    .offset(x: 20, y: 20)
                shape
                    .fill(LinearGradient(Color.offOrangeWhite, Color.white))
                    .blur(radius: 4)
                    .padding(2)
                shape
                    .foregroundColor(Color.offOrangeWhiteDark.opacity(0.3))
                    .frame(width: 15, height: 5)
                    .offset(x: 0, y: 15)
            }
            .clipShape(shape)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: -5)
            .shadow(color: Color.white.opacity(0.8), radius: 10, x: 10, y: 10)
        } else {
            ZStack {
                Color.offOrangeWhite
                shape
                    .foregroundColor(.white)
                    .blur(radius: 4)
                    .offset(x: -8, y: -8)
                shape
                    .fill(LinearGradient(Color.offOrangeWhite, Color.white))
                    .padding(2)
                    .blur(radius: 2)
            }
            .clipShape(shape)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
    }
}

struct Neumorphic: ButtonStyle {
    let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(15)
            .contentShape(shape)
            .background(
                ToggleNeumorphic(isHighlighted: configuration.isPressed, shape: shape)
            )
    }
}

struct CustomSlider: View {
    @Binding var percentage: Double
    var shape = RoundedRectangle(cornerRadius: 12)

    var body: some View {
        GeometryReader { geometry in
            shape
                .foregroundColor(Color.white)
                .blur(radius: 5)
                .offset(x: -3, y: -10)
                .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            shape
                .foregroundColor(Color.black.opacity(0.1))
                .blur(radius: 5)
                .offset(x: -5, y: 10)
                .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            ZStack(alignment: .leading) {
                Color.white
                shape
                    .foregroundColor(.black.opacity(0.2))
                    .blur(radius: 4)
                    .offset(x: -2, y: -20)
                shape
                    .foregroundColor(.white.opacity(0.3))
                    .blur(radius: 4)
                    .offset(x: 3, y: 20)
                ZStack {
                    shape
                        .foregroundColor(Color.black.opacity(0.3))
                        .blur(radius: 5)
                        .offset(x: 5, y: 0)
                        .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
                    shape
                        .foregroundColor(.offOrangeWhite)
                        .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
                }
            }
            .clipShape(shape)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    self.percentage = min(max(0, Double(value.location.x / geometry.size.width * 100)), 100)
                }))
        }
    }
}

struct ContentView: View {
    @State private var percentage = 10.0
    @State private var score = 0
    @State private var activeLevel = "Easy"
    @State private var animationAmount = 1.0
    let levels: [String] = ["Easy", "Medium", "Hard"]
    let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
    
    var table: Int {
        return Int(ceil(percentage / 5).formatted())!
    }
    
    @State private var multiplier: Int = 1
    
    var rightAnswer: Int {
        return table * multiplier
    }
    
    var filler: Int {
        let randomNumber = Int.random(in: 1..<10)
        return [rightAnswer, rightAnswer - randomNumber, rightAnswer + randomNumber].randomElement()!
    }

    var body: some View {
        ZStack {
            Color.offOrangeWhite
            VStack {
                Text("Multiplication")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(.gray)
                Text("Table of \(table)")
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    .foregroundColor(.gray)
                CustomSlider(percentage: $percentage)
                    .frame(width: 300, height: 25)
                Text("Levels")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundColor(.gray)
                HStack {
                    ForEach(levels, id: \.self) { level in
                        Button {
                            activeLevel = level
                        } label: {
                            Text("\(level)")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.gray)
                                .padding(15)
                                
                        }
                        .contentShape(shape)
                        .background(
                            ToggleNeumorphic(isHighlighted: level == activeLevel, shape: shape)
                        )
                        .animation(.easeInOut, value: activeLevel)
                        .padding()
                    }
                }
                Text("\(table) x \(multiplier) = \(filler)")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(.gray)
                    .padding()
                HStack {
                    Button {
                        isCorrect(userAnswer: true)
                    } label: {
                        Text("True")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(Neumorphic())
                    .padding()
                    .animation(
                        .easeIn,
                        value: multiplier
                    )
                    Button {
                        isCorrect(userAnswer: false)
                    } label: {
                        Text("False")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(Neumorphic())
                    .padding()
                }
                
                HStack {
                    Text("Score: ")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(.gray)
                    Text("\(score)")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(.gray)
                        .scaleEffect(animationAmount)
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            getMultiplier()
        }
    }
    
    func isCorrect(userAnswer: Bool) {
        let correctAnswer = rightAnswer == filler
        
        if correctAnswer == userAnswer {
            score += 1
            animationAmount += 2
            withAnimation(.easeInOut.delay(0.1).repeatCount(1, autoreverses: true)) {
                animationAmount -= 2
            }
        }
        
        getMultiplier()
    }
    
    func getMultiplier() {
        switch activeLevel {
        case "Easy":
            multiplier = Int.random(in: 1..<8)
            return
        case "Medium":
            multiplier = Int.random(in: 8..<15)
            return
        case "Hard":
            multiplier = Int.random(in: 15..<21)
            return
        default:
            multiplier = 1
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

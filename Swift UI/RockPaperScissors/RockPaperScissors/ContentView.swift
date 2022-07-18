//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andrey Ramirez on 7/18/22.
//

import SwiftUI

struct Background: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        Circle()
                            .frame(width: 300)
                            .foregroundColor(Color.green.opacity(0.3))
                            .blur(radius: 10)
                            .offset(x: 150, y: -300)
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .frame(width: 500, height: 500)
                            .foregroundStyle(LinearGradient(colors: [Color.pink.opacity(0.3), Color.mint.opacity(0.5)], startPoint: .top, endPoint: .leading))
                            .offset(x: -200)
                            .blur(radius: 30)
                            .rotationEffect(.degrees(30))

                        Circle()
                            .frame(width: 450)
                            .foregroundStyle(Color.blue.opacity(0.2))
                            .blur(radius: 20)
                            .offset(x: 200, y: 400)
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func glassmorphism() -> some View {
        self.modifier(Background())
    }
}

struct YAxisSpin<Front: View>: View {
    var front: () -> Front
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    @Binding var isFlipped: Bool
    
    init(isFlipped: Binding<Bool>, @ViewBuilder front: @escaping () -> Front) {
        self._isFlipped = isFlipped
        self.front = front
    }
    
    var body: some View {
        front()
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .onAppear(perform: {
            var totalTime = 1.0
            Timer.scheduledTimer(withTimeInterval: totalTime, repeats: true) { _ in
                totalTime += 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + totalTime) {
                    flipFlashcard()
                }
            }
        })
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipFlashcard() {
        let animationTime = 0.2
        let multiplier = 10.0
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += (180 * multiplier)
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += (180 * multiplier)
            self.isFlipped.toggle()
        }
    }
}

struct FlashCard: View {
    let sign: String
    let size: CGFloat
    let hasBGColor: Bool

    var body: some View {
        if hasBGColor {
            Text(sign)
                .font(.system(size: size))
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
        } else {
            Text(sign)
                .font(.system(size: size))
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct ContentView: View {
    var signs = ["✊🏼", "🖐🏼", "✌🏼"]
    var goals = ["Win", "Lose"]
    @State private var correctSign: String = ""
    @State private var correctGoal: String = ""
    @State private var isFlipped: Bool = false
    @State private var score: Int = 0
    @State private var shouldShake: Bool = false

    var body: some View {
        VStack {
            VStack {
                Text("Speed Jankenpon")
                    .font(.largeTitle.weight(.black))
                    .foregroundColor(.white)
                    .padding()
                YAxisSpin(isFlipped: $isFlipped, front: {
                    FlashCard(sign: correctSign, size: 150, hasBGColor: false)
                    FlashCard(sign: correctGoal, size: 80, hasBGColor: false)
                })
                Text("Score: \(score)")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                    .padding()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            HStack {
                ForEach(signs, id: \.self) { sign in
                    Button {
                        onPressSign(sign: sign)
                    } label: {
                        let startAnimation = shouldShake && isCorrect(sign: sign, goal: goals[0] == correctGoal)
                        FlashCard(sign: sign, size: 80, hasBGColor: true)
                            .offset(x: startAnimation ? 30 : 0)
                    }
                }
            }
        }
        .glassmorphism()
        .onAppear(perform: {
            correctSign = signs[Int.random(in: 0...2)]
            correctGoal = goals[Int.random(in: 0...1)]
        })
        .onChange(of: isFlipped) { _ in
            correctSign = signs[Int.random(in: 0...2)]
            correctGoal = goals[Int.random(in: 0...1)]
        }
    }
    
    func onPressSign(sign: String) {
        let shouldScore = isCorrect(sign: sign, goal: goals[0] == correctGoal)
        
        if shouldScore {
            score += 1
        } else {
            shouldShake.toggle()
            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                shouldShake.toggle()
            }
        }
    }
    
    func isCorrect(sign: String, goal: Bool) -> Bool {
        switch correctSign {
        case signs[0]:
            return goal ? signs[1] == sign : signs[2] == sign
        case signs[1]:
            return  goal ? signs[2] == sign : signs[0] == sign
        case signs[2]:
            return  goal ? signs[0] == sign : signs[1] == sign
        default:
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  BugSweeper
//
//  Created by Andrey Ramirez on 7/17/22.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct Background: ViewModifier {
    static let color0 = Color(red: 238/255, green: 130/255, blue: 238/255);
    static let color1 = Color(red: 0/255, green: 0/255, blue: 255/255);
    let gradient = Gradient(colors: [color0, color1]);
    @State var start = UnitPoint(x: 0.00, y: 0.50)
    @State var end = UnitPoint(x: 1.00, y: 0.50)

    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
              gradient: gradient,
              startPoint: start,
              endPoint: end
            )
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                        self.start = UnitPoint(x: 0.50, y: 1)
                        self.end = UnitPoint(x: 0.50, y: 1.00)
                        self.start = UnitPoint(x: 1.00, y: 0.50)
                        self.end = UnitPoint(x: 0.00, y: 0.50)
                        self.start = UnitPoint(x: 0.50, y: 1.00)
                        self.end = UnitPoint(x: 0.50, y: 0.00)
                    }
                }
                .overlay(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            content
        }
    }
}

struct Cell: View {
    let isDone: Bool
    let isCorrect: Bool

    var body: some View {
        if isDone {
            if isCorrect {
                Text("🐛")
                    .frame(width: 20, height: 20)
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.clear)
                    .background(.clear)
                    .frame(width: 20, height: 20)
            }
        } else {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.clear)
                .background(.ultraThinMaterial)
                .frame(width: 20, height: 20)
        }
    }
}

struct Block: View {
    let isCorrect: Bool
    @Binding var isFinished: Bool
    @State private var isDone: Bool = false

    var body: some View {
        Button {
            isDone = true
            if isCorrect {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFinished = true
                }
            }
        } label: {
            Cell(isDone: isDone, isCorrect: isCorrect)
        }
        .onChange(of: isFinished) { newValue in
            isDone = false
        }
    }
}

extension View {
    func animateBackground() -> some View {
        self.modifier(Background())
    }
}

struct ContentView: View {
    private let r = 26
    private let c = 12
    @State private var a: [Int] = []
    @State var isFinished: Bool = false

    var body: some View {
        GridStack(rows: r, columns: c) { x, y in
            Block(isCorrect: !a.isEmpty ? x == a[0] && y == a[1] : false, isFinished: $isFinished)
        }
        .onAppear(perform: {
            a = [Int.random(in: 0..<r), Int.random(in: 1..<c)]
        })
        .alert("Congratulations!", isPresented: $isFinished) {
            Button("Reset", action: reset)
        } message: {
            Text("Well done bug sweeper!")
        }
        .animateBackground()
    }
    
    func reset() {
        isFinished = false
        a = [Int.random(in: 0..<r), Int.random(in: 1..<c)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

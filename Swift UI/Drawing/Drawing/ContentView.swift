//
//  ContentView.swift
//  Drawing
//
//  Created by Andrey Ramirez on 7/25/22.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            path.addLines( [
                CGPoint(x: width * 0.4, y: height),
                CGPoint(x: width * 0.4, y: height * 0.4),
                CGPoint(x: width * 0.2, y: height * 0.4),
                CGPoint(x: width * 0.5, y: height * 0.1),
                CGPoint(x: width * 0.8, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height * 0.4),
                CGPoint(x: width * 0.6, y: height)
                
            ])
            path.closeSubpath()
        }
    }
}

struct AnimatedArrow: View {
    var amount: Double
    
    var animatableData: Double {
        get { amount }
        set {
            amount = newValue
        }
    }
    
    var body: some View {
        Arrow()
            .stroke(.black, style: StrokeStyle(lineWidth: amount * 20, lineCap: .round, lineJoin: .round))
    }
}

struct ColorCyclingRect: View {
      var amount = 0.0
      var steps = 150

      var body: some View {
          ZStack {
              ForEach(0..<steps) { value in
                  RoundedRectangle(cornerRadius: 25)
                      .inset(by: Double(value))
                      .strokeBorder(
                          LinearGradient(
                              gradient: Gradient(colors: [
                                  color(for: value, brightness: 1),
                                  color(for: value, brightness: 0.5)
                              ]),
                              startPoint: .top,
                              endPoint: .bottom
                          ),
                          lineWidth: 2
                      )
              }
          }
          .drawingGroup()
      }

      func color(for value: Int, brightness: Double) -> Color {
          var targetHue = Double(value) / Double(steps) + amount

          if targetHue > 1 {
              targetHue -= 1
          }
          
          return Color(hue: targetHue, saturation: 1, brightness: brightness)
      }
  }
struct ContentView: View {
      @State private var amount = 0.0

      var body: some View {
          VStack {
              ColorCyclingRect(amount: amount)
                  .frame(width: 300, height: 300)
              AnimatedArrow(amount: amount)
              Slider(value: Binding(get: {
                  amount
              }, set: { newValue in
                  withAnimation {
                      amount = newValue
                  }
              }))
          }
      }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

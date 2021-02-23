//
//  ContentView.swift
//  HM4_SliderScore
//
//  Created by Oleg Krikun on 23.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Double.random(in: 0...100)
    @State private var currentValue = Double.random(in: 0...100)
    @State private var thumbAlpha: CGFloat = 1.0
    @State private var showAlert = false
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер, как можно ближе к: \(lround(targetValue))")
            HStack {
                Text("0")
                ScoreSlider(
                    value: $currentValue,
                    thumbColor: UIColor(.blue),
                    thumbAlpha: thumbAlpha
                )
                .onChange(of: currentValue, perform: { value in
                    thumbAlpha = CGFloat((110 - abs(targetValue - currentValue)) / 140)
                })
                .onAppear(perform: {
                    thumbAlpha = CGFloat((110 - abs(targetValue - currentValue)) / 140)
                })
                Text("100")
            }
            
            Button(action: computeScore, label: {
                Text("Проверь меня!")
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Your score!"),
                              message: Text("\(score)")
                        )
                    }
            })
            .offset(x: 0.0, y: 24.0)
            
            Button(action: resetGame, label: {
                Text("Начать заново")
            })
            .offset(x: 0.0, y: 48.0)
            
        }.padding()
    }
}

extension ContentView {
    private func computeScore() {
        let difference = abs(lround(targetValue) - lround(currentValue))
        score = 100 - difference
        showAlert = true
    }
    
    private func resetGame() {
        targetValue = Double.random(in: 0...100)
        currentValue = Double.random(in: 0...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

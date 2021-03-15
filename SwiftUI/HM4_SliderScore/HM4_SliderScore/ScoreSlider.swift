//
//  ScoreSlider.swift
//  HM4_SliderScore
//
//  Created by Oleg Krikun on 23.02.2021.
//

import SwiftUI

struct ScoreSlider: UIViewRepresentable {
    @Binding var value: Double
    
    let thumbColor: UIColor
    let thumbAlpha: CGFloat
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ view: UISlider, context: Context) {
        view.value = Float(value)
        view.thumbTintColor = thumbColor.withAlphaComponent(thumbAlpha)
    }
    
    func makeCoordinator() -> ScoreSlider.Coordinator {
        Coordinator(value: $value)
    }
}

extension ScoreSlider {
    class Coordinator: NSObject {
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct ScoreSlider_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSlider(value: .constant(10.0), thumbColor: .blue, thumbAlpha: 0.2)
    }
}

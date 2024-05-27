//
//  SliderView.swift
//  DrgonBallWiki
//
//  Created by Byron on 27/5/24.
//

import SwiftUI

struct SliderView: View {

    @Binding var value: Double

    var range: ClosedRange<Double>
    var thumbSize: CGFloat = 10
    var trackHeight: CGFloat = 5
    var thumbColor: Color = .red
    var trackColor: Color = .black
    var progressColor: Color = .red
    var onEditingChanged: ((Bool) -> Void)? = nil

    @GestureState private var isDragging = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(height: trackHeight)

                Capsule()
                    .fill(progressColor)
                    .frame(width: geometry.size.width * progress, height: trackHeight)

                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: geometry.size.width * progress - thumbSize / 2)
                    .gesture(
                        DragGesture()
                            .updating($isDragging) { _, state, _ in
                                state = true
                            }
                            .onChanged { gesture in
                                let newValue = calculateValue(from: gesture.location.x, in: geometry.size.width)
                                value = min(max(newValue, range.lowerBound), range.upperBound)
                                onEditingChanged?(true)
                            }
                            .onEnded { _ in
                                onEditingChanged?(false)
                            }
                    )
            }
            .compositingGroup()
        }
        .frame(height: thumbSize)
        .onChange(of: isDragging) {
            if !isDragging {
                onEditingChanged?(false)
            }
        }
    }

    private var progress: CGFloat {
        CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
    }

    private func calculateValue(from location: CGFloat, in width: CGFloat) -> Double {
        Double(location / width) * (range.upperBound - range.lowerBound) + range.lowerBound
    }
}

#Preview {
    SliderView(value: .constant(1), range: 0...3)
    .padding()
}

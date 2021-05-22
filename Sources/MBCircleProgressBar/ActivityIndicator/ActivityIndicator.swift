//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2021/05/21.
//

import SwiftUI

public struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false
    public init() {}
    
    private func scale(_ index: Int) -> CGFloat {
        self.isAnimating ? 1 - CGFloat(index) * 0.2 : 0.2 + CGFloat(index) * 0.2
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ForEach(0 ..< 5) { index in
                Circle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.2)
//                    .scaleEffect(scale(index))
                    .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                                .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear{ isAnimating.toggle() }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}

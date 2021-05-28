import Foundation
import SwiftUI

public struct MBCircleProgressView: View {
    @ObservedObject var progressModel: MBCircleProgressModel
    
    public init(data progressModel: MBCircleProgressModel) {
        self.progressModel = progressModel
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(progressModel.emptyLineColor, lineWidth: progressModel.lineWidth)
                    .opacity(0.3)
                Circle()
                    .trim(from: 0, to: progressModel.percent)
                    .stroke(progressModel.progressColor, lineWidth: progressModel.lineWidth)
                    .rotationEffect(.degrees(-90))
            }
            .overlay(
                VStack {
                    Text("\(Int(progressModel.value)) / \(Int(progressModel.maxValue))")
                    Text(progressModel.progressMode.rawValue)
                }
                .font(.system(size: 18, design: .monospaced))
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onDisappear(perform: progressModel.reset)
    }
}

extension CGFloat {
    var roundValue: CGFloat {
        return (self * 10000).rounded(.toNearestOrAwayFromZero) / 100
    }
}

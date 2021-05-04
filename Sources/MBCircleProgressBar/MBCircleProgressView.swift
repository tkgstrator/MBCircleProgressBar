import Foundation
import SwiftUI

public struct MBCircleProgressView: View {
    @ObservedObject var progressModel: MBCircleProgressModel
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(progressModel.emptyLineColor, lineWidth: progressModel.lineWidth)
                .opacity(0.3)
            Circle()
                .trim(from: 0, to: progressModel.progress)
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
        .frame(width: progressModel.width, height: progressModel.width)
    }
    
    public init(data progressModel: MBCircleProgressModel) {
        self.progressModel = progressModel
    }
}

extension CGFloat {
    var roundValue: CGFloat {
        return (self * 10000).rounded(.toNearestOrAwayFromZero) / 100
    }
}

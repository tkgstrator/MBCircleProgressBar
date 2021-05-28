//
//  MBCirlceProgressModel.swift
//  
//
//  Created by devonly on 2021/05/04.
//

import Foundation
import SwiftUI

public class MBCircleProgressModel: ObservableObject {
    @Published var value: CGFloat = 0
    @Published var maxValue: CGFloat = 0
    @Published var width: CGFloat
//    @Published var showValueString: Bool
//    @Published var showUnitString: Bool
//    @Published var valueFontName: String
//    @Published var valueFontSize: CGFloat
//    @Published var unitFontName: String
    @Published var unitString: String
//    @Published var fontColor: Color
//    @Published var decimalPlaces: Int
//    @Published var progressRotationAngle: CGFloat
//    @Published var progressAngle: CGFloat
//    @Published var progressLineWidth: CGFloat
    @Published var progressMode: ProgressModeType
    @Published var progressColor: Color
    @Published var lineWidth: CGFloat
//    @Published var progressStrokeColor: Color
//    @Published var progressCapType: ProgressCapType
//    @Published var emptyLineWidth: CGFloat
    @Published var emptyLineColor: Color
//    @Published var emptyCapType: ProgressCapType
//    @Published var textOffset: CGPoint
    var percent: CGFloat {
        if maxValue == 0 { return 0.0 }
        else { return value / maxValue }
    }
    @Published public var isCompleted: Bool = false

    public init(
        progressColor: Color,
        emptyLineColor: Color,
        lineWidth: CGFloat = 5
    ) {
        self.progressColor = progressColor
        self.emptyLineColor = emptyLineColor
        self.lineWidth = lineWidth
        self.width = 180
        self.unitString = "%"
        self.progressMode = .download
    }

    //    public init(
//        value: CGFloat,
//        maxValue: CGFloat,
//        showValueString: Bool = false,
//        showUnitString: Bool = false,
//        valueFontName: String = "",
//        valueFontSize: CGFloat,
//        unitFontName: String = "",
//        unitString: String,
//        fontColor: Color,
//        decimalPlaces: Int,
//        progressRotationAngle: CGFloat,
//        progressAngle: CGFloat,
//        progressLineWidth: CGFloat,
//        progressColor: Color,
//        progressStrokeColor: Color,
//        progressCapType: ProgressCapType = .round,
//        emptyLineWidth: CGFloat,
//        emptyLineColor: Color,
//        emptyCapType: ProgressCapType,
//        textOffset: CGPoint
//    ) {
//        self.value = value
//        self.maxValue = maxValue
//        self.showValueString = showValueString
//        self.showUnitString = showUnitString
//        self.valueFontName = valueFontName
//        self.valueFontSize = valueFontSize
//        self.unitFontName = unitFontName
//        self.unitString = unitString
//        self.fontColor = fontColor
//        self.decimalPlaces = decimalPlaces
//        self.progressRotationAngle = progressRotationAngle
//        self.progressAngle = progressAngle
//        self.progressLineWidth = progressLineWidth
//        self.progressColor = progressColor
//        self.progressStrokeColor = progressStrokeColor
//        self.progressCapType = progressCapType
//        self.emptyLineWidth = emptyLineWidth
//        self.emptyLineColor = emptyLineColor
//        self.emptyCapType = emptyCapType
//        self.textOffset = textOffset
//    }

    public func configure(maxValue: CGFloat) {
        withAnimation {
            self.maxValue = maxValue
        }
    }
    
    public func addValue(value: CGFloat) {
        withAnimation {
            self.value = min(maxValue, self.value + value)
        }
        
        if self.value == maxValue {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isCompleted = true
            }
        }
    }
    
    public func changeMode(mode: ProgressModeType) {
        withAnimation {
            self.progressColor = .blue
            self.progressMode = mode
        }
    }

    // 初期値に戻す
    func reset() {
        self.isCompleted = false
        self.value = 0
        self.maxValue = 0
    }
}

public enum ProgressCapType: CaseIterable {
    case butt
    case round
    case square
}

public enum ProgressModeType: String, CaseIterable {
    case upload     = "Uploading"
    case download   = "Downloading"
    case compress   = "Compressing"
}

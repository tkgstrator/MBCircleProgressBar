//
//  ContentView.swift
//  MBCircleProgressBarDemo
//
//  Created by devonly on 2021/05/04.
//

import SwiftUI
import MBCircleProgressBar
import Combine

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var progressModel = MBCircleProgressModel(progressColor: Color.red, emptyLineColor: Color.gray)
    var body: some View {
        MBCircleProgressView(data: progressModel)
            .frame(width: 200, height: 200)
            .onAppear {
                withAnimation {
                    progressModel.maxValue = 100
                }
            }
            .onReceive(timer) { _ in
                withAnimation {
                    progressModel.value += 1
                    if progressModel.value >= 100 {
                        progressModel.value = 0
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

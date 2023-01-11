//
//  CIDChartView.swift
//  Cepik
//
//  Created by Maksymilian Stan on 30/11/2022.
//

import SwiftUI
import Charts

struct CIDChartView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Chart {
                BarMark(
                    x: .value("Test1", "Sty"),
                    y: .value("Test1", 1500)
                )
                BarMark(
                    x: .value("Test2", "Lut"),
                    y: .value("Test2", 543)
                )
                BarMark(
                    x: .value("Test22", "Lut"),
                    y: .value("Test22", 1000)
                ).foregroundStyle(Color.red)
                BarMark(
                    x: .value("Test3", "Mar"),
                    y: .value("Test3", 876)
                )
                BarMark(
                    x: .value("Test4", "Kwi"),
                    y: .value("Test4", 123)
                )
                BarMark(
                    x: .value("Test5", "Maj"),
                    y: .value("Test5", 543)
                )
                BarMark(
                    x: .value("Test6", "Czerwiec"),
                    y: .value("Test6", 1900)
                )
                BarMark(
                    x: .value("Test7", "Lip"),
                    y: .value("Test7", 234)
                )
                BarMark(
                    x: .value("Test8", "Sie"),
                    y: .value("Test8", 500)
                )
                BarMark(
                    x: .value("Test9", "Wrz"),
                    y: .value("Test9", 342)
                )
                BarMark(
                    x: .value("Test10", "Paź"),
                    y: .value("Test10", 1000)
                )
                BarMark(
                    x: .value("Test11", "Lis"),
                    y: .value("Test11", 787)
                )
                BarMark(
                    x: .value("Test12", "Gru"),
                    y: .value("Test12", 122)
                )
            }
        }
    }
}

struct CIDChartView_Previews: PreviewProvider {
    static var previews: some View {
        CIDChartView()
    }
}

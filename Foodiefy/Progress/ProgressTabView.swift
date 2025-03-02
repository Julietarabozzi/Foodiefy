//
//  ProgressTabView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 02/03/2025.
//

import Foundation
import SwiftUI

struct ProgressTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Seguimiento").tag(0)
                Text("Gráfico").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedTab == 0 {
                WeeklyProgressView()
            } else {
                WeeklyProgressChartView()
            }
        }
    }
}

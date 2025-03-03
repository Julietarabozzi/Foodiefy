//
//  ARScanView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 02/03/2025.
//

import Foundation
import SwiftUI
import ARKit
import Vision

struct ARScannerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: FoodScannerViewModel

    func makeUIViewController(context: Context) -> ARScannerViewController {
        let controller = ARScannerViewController()
        controller.viewModel = viewModel // 🔹 Pasar el ViewModel
        return controller
    }

    func updateUIViewController(_ uiViewController: ARScannerViewController, context: Context) {}
}

//
//  ARScanViewController.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 02/03/2025.
//

import Foundation
import ARKit
import UIKit
class ARScannerViewController: UIViewController, ARSCNViewDelegate {
    let sceneView = ARSCNView()
    let captureButton = UIButton()
    var viewModel: FoodScannerViewModel? // 🔹 Recibir el ViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        setupCaptureButton()
    }

    func setupARView() {
        sceneView.frame = view.bounds
        sceneView.delegate = self
        sceneView.session.run(ARWorldTrackingConfiguration())
        view.addSubview(sceneView)
    }

    func setupCaptureButton() {
        captureButton.setTitle("📸 Escanear", for: .normal)
        captureButton.backgroundColor = .blue
        captureButton.layer.cornerRadius = 10
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)

        view.addSubview(captureButton)
        NSLayoutConstraint.activate([
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.widthAnchor.constraint(equalToConstant: 150),
            captureButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func captureImage() {
        let image = sceneView.snapshot()
        processImage(image)
    }

    func processImage(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else { return }

        // 🔹 Cargar el modelo de CoreML
        guard let model = try? VNCoreMLModel(for: MobileNetV2Int8LUT().model) else {
            print("❌ Error al cargar el modelo de Machine Learning")
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                print("❌ No se pudo reconocer el alimento")
                return
            }

            DispatchQueue.main.async {
                let foodName = topResult.identifier // 🔹 Nombre del alimento detectado
                print("🍌 Alimento detectado: \(foodName)")
                self.viewModel?.fetchNutrients(for: foodName) // 🔹 Buscar nutrientes en Edamam
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])
    }
}

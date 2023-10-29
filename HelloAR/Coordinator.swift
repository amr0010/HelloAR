//
//  Coordinator.swift
//  HelloAR
//
//  Created by Amr Magdy on 29/10/2023.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            let material = SimpleMaterial(color: UIColor.random, isMetallic: true)
            entity.model?.materials = [material]
        }
    }
    
}

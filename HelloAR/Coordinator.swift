//
//  Coordinator.swift
//  HelloAR
//
//  Created by Amr Magdy on 29/10/2023.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject {
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            let material = SimpleMaterial(color: UIColor.random, isMetallic: true)
            entity.model?.materials = [material]
        } else {
            let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical) + view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
            
            if let result = results.first {
                
                let anchorEntity = AnchorEntity(raycastResult: result)
//                let material = SimpleMaterial(color: .red, isMetallic: true)
//                let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3) , materials: [material])
                guard let modelEntity = try? ModelEntity.loadModel(named: "chair") else {
                    fatalError("chair model not found")
                }
                anchorEntity.addChild(modelEntity)
                view.scene.addAnchor(anchorEntity)
            }
        }
    }
    
}

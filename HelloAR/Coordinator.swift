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
        } else {
            let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
            
            if let result = results.first {
                let anchor = ARAnchor(name: "Plane Anchor", transform: result.worldTransform)
                view.session.add(anchor: anchor)
                
                let material = SimpleMaterial(color: .red, isMetallic: true)
                let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3) , materials: [material])
                
                let anchorEntity = AnchorEntity(anchor: anchor)
                anchorEntity.addChild(box)
                
                view.scene.addAnchor(anchorEntity)
            }
        }
    }
    
}

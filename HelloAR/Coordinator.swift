//
//  Coordinator.swift
//  HelloAR
//
//  Created by Amr Magdy on 29/10/2023.
//

import Foundation
import ARKit
import RealityKit
import Combine

class Coordinator: NSObject {
    weak var view: ARView?
    var cancellable: AnyCancellable?
    
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
                
                cancellable = ModelEntity.loadAsync(named: "chair")
                    .append(ModelEntity.loadAsync(named: "tv"))
                    .collect()
                    .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("unable to load model \(error.localizedDescription)")
                    }
                }, receiveValue: { entities in
                    var x: Float = 0.0
                    entities.forEach { entity in
                        entity.position = simd_make_float3(x, 0, 0)
                        x += 0.3
                        anchorEntity.addChild(entity)
                    }
                    
                })
                view.scene.addAnchor(anchorEntity)
            }
        }
    }
    
}

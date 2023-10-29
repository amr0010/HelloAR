//
//  ContentView.swift
//  HelloAR
//
//  Created by Amr Magdy on 29/10/2023.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:))))
        
        context.coordinator.view = arView
        let anchor = AnchorEntity(plane: .horizontal)
        
        let material = SimpleMaterial(color: .red, isMetallic: true)
        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3) , materials: [material])
        
        let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.3), materials: [SimpleMaterial(color: .yellow, isMetallic: true)])
        let plane = ModelEntity(mesh: MeshResource.generatePlane(width: 0.5, depth: 0.3), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        
        let text = ModelEntity(mesh: MeshResource.generateText("Tap on an object to change color", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.2), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [SimpleMaterial(color: .white, isMetallic: true)])
        
        sphere.position = simd_make_float3(0, 0.4, 0)
        plane.position = simd_make_float3(0, 0.7, 0)
        text.position = simd_make_float3(0, 0.9, 0)
        
        box.generateCollisionShapes(recursive: true)
        sphere.generateCollisionShapes(recursive: true)
        plane.generateCollisionShapes(recursive: true)
        text.generateCollisionShapes(recursive: true)

        anchor.addChild(box)
        anchor.addChild(sphere)
        anchor.addChild(plane)
        anchor.addChild(text)
        
        arView.installGestures(.all, for: box)
        arView.installGestures(.all, for: sphere)
        arView.installGestures(.all, for: plane)
        arView.installGestures(.all, for: text)
        
        arView.scene.anchors.append(anchor)
        return arView
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}

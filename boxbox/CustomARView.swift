//
//  CustomARView.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//


import ARKit
import Foundation
import RealityKit
import SwiftUI
import Combine
import FocusEntity

class CustomARView: ARView {
    var viewModel: ObjectViewModel
    let boxName = "box"
    
    required init(frame frameRect: CGRect) {
        fatalError("ERRRROR required init")
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("ERRRROR")
    }
    
    init(viewModel: ObjectViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        subscribeToActionStream()
        _ = FocusEntity(on: self, style: .classic())
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let floor = ModelEntity(mesh: MeshResource.generateBox(size: [1000, 0, 1000]), materials: [OcclusionMaterial()])
        floor.physicsBody = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .static)
        floor.generateCollisionShapes(recursive: true)
        
        self.scene.addAnchor(anchor)
        self.enableObjectRemoval()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared.actionStreams
            .sink { [weak self] action in
                switch action {
                case .placeBlock:
                    self?.placeBlock()
                case .removeAllAnchors:
                    self?.removeBox()
                case .placeSphere(let location):
                    self?.placeSphere(location: location)
                }
            }
            .store(in: &cancellables)
    }
    
    func placeBlock() {
        let anchor = AnchorEntity(plane: AnchoringComponent.Target.Alignment.horizontal)
        let box = MovalbleEntity(size: 1, color: viewModel.color.withAlphaComponent(0.7), shape: .box)
        box.scale = viewModel.scaleInMeter
        self.installGestures([.translation, .rotation], for: box)
        anchor.addChild(box)
        anchor.name = boxName
        self.scene.anchors.append(anchor)
    }
    
    
    func placeSphere(location: CGPoint) {
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: ARRaycastQuery.TargetAlignment.horizontal)
        if let firstResult = results.first {
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            let material = SimpleMaterial(color: .yellow, roughness: 0, isMetallic: true)
            let sphere =  ModelEntity(mesh: MeshResource.generateSphere(radius: 0.05), materials: [material])
            
            let objectAnchor = AnchorEntity(world: worldPos)
            objectAnchor.name = "sphere"
            objectAnchor.addChild(sphere)
            installGesture(on: sphere)

            self.scene.addAnchor(objectAnchor)
        }
    }
    
    func installGesture(on object: ModelEntity) {
        object.generateCollisionShapes(recursive: true)
        self.installGestures([.translation], for: object)
    }
    
    func enableObjectRemoval() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPress)
    }
    
    func removeBox() {
        self.scene.anchors.forEach({ [weak self] entity in
            if entity.name == self?.boxName {
                entity.removeFromParent()
            }
        })
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location) {
            if let anchorEntity = entity.anchor, anchorEntity.name == "sphere" {
                anchorEntity.removeFromParent()
                print("Remove anchorEntity from ARView: \(anchorEntity.name)")
            }
        }
    }
}

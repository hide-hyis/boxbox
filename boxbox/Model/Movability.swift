//
//  Movability.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import Foundation
import UIKit
import RealityKit

enum Shape {
    case box, sphere
}

class MovalbleEntity: Entity, HasModel, HasPhysics, HasCollision {
    
    var size: Float!
    var color: UIColor!
    var shape: Shape = .box
    
    init(size: Float, color: UIColor, shape: Shape) {
        super.init()
        self.size = size
        self.color = color
        self.shape = shape
        let mesh = generateMeshResource()
        let material = generateMaterial()
        model = ModelComponent(mesh: mesh, materials: [material])
        physicsBody = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .static)
        collision = CollisionComponent(shapes: [generateShapeResource()], mode: .trigger, filter: .sensor)
        generateCollisionShapes(recursive: true)
    }
    
    private func generateShapeResource() -> ShapeResource {
        switch shape {
        case .box:
            return ShapeResource.generateBox(size: [self.size, self.size, self.size])
        case .sphere:
            return ShapeResource.generateSphere(radius: self.size)
        }
    }
    private func generateMeshResource() -> MeshResource {
        switch shape {
        case .box:
            return MeshResource.generateBox(size: self.size)
        case .sphere:
            return MeshResource.generateSphere(radius: self.size)
        }
    }
    
    private func generateMaterial() -> Material {
        SimpleMaterial(color: color, isMetallic: false)
    }
    required init() {
        fatalError()
    }
}

//
//  ObjectViewModel.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import Foundation
import UIKit

class ObjectViewModel: ObservableObject {
    var scale = SIMD3<Float>(10, 10, 10)
    var color = UIColor.red
    
    var scaleX: Float {
        get {
            return scale.x
        }
        set {
            scale.x = newValue
        }
    }
    
    var scaleY: Float {
        get {
            return scale.y
        }
        set {
            scale.y = newValue
        }
    }
    
    var scaleZ: Float {
        get {
            return scale.z
        }
        set {
            scale.z = newValue
        }
    }
    
    var scaleInMeter: SIMD3<Float> {
        return SIMD3(x: scale.x / 100, y: scale.y / 100, z: scale.z / 100)
    }
}

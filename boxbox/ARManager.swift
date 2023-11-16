//
//  ARManager.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import Foundation
import Combine

class ARManager {
    static let shared = ARManager()
    private init() {}
    
    var actionStreams = PassthroughSubject<ARAction, Never>()
}

//
//  ARViewContainer.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import Foundation
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    var viewModel: ObjectViewModel
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView(viewModel: viewModel)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
}

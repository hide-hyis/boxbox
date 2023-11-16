//
//  ContentView.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var placeMode = false
    @State private var showSizeView = false
    @State var viewModel = ObjectViewModel()
    
    var body: some View {
        ARViewContainer(viewModel: viewModel)
            .edgesIgnoringSafeArea(.all)
            .overlay(alignment: .bottom) {
                if !placeMode {
                    BottomButton(placeMode: $placeMode, showSizeView: $showSizeView)
                }
            }
            .onTapGesture(coordinateSpace: .local) { location in
                guard placeMode else { return }
                print("x: \(location.x) y:\(location.y)")
                ARManager.shared.actionStreams.send(.placeSphere(location: location))
                placeMode = false
            }
            .sheet(isPresented: $showSizeView,
                   onDismiss: {
                print("view model scale: \(viewModel.scale.x) / \(viewModel.scale.y) / \(viewModel.scale.z)")
            },
                   content: {
                EditSizeView(viewModel: $viewModel, showSizeView: $showSizeView)
            })
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

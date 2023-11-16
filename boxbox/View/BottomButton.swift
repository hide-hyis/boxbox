//
//  BottomButton.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import SwiftUI

struct BottomButton: View {
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    @Binding var placeMode: Bool
    @Binding var showSizeView: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                Button {
                    placeMode = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(.regularMaterial)
                }
                
                Button {
                    ARManager.shared.actionStreams.send(.placeBlock)
                } label: {
                    Image(systemName: "plus.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(.regularMaterial)
                }
                
                Button {
                    showSizeView = true
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(.regularMaterial)
                }
                
                Button {
                    ARManager.shared.actionStreams.send(.removeAllAnchors)
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(.regularMaterial)
                }

            }
            .padding()
        }
    }
}

struct BottomButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomButton(placeMode: .constant(false), showSizeView: .constant(false))
    }
}

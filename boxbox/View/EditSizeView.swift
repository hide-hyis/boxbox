//
//  EditSizeView.swift
//  boxbox
//
//  Created by HIDEYASU ISHII on 2023/11/17.
//

import SwiftUI

struct EditSizeView: View {
    @State private var x = "0"
    @State private var y = "0"
    @State private var z = "0"
    @Binding var viewModel: ObjectViewModel
    @Binding var showSizeView: Bool
    
    var body: some View {
        List {
            Section(header: Text("幅×奥行き×高さ(cm)")) {
                HStack(alignment: .center) {
//                    Text("幅")
                    TextField("幅", value: $viewModel.scaleX, format: .number)
                        .keyboardType(.decimalPad)
                }
                HStack {
//                    Text("奥行き")
                    TextField("奥行き", value: $viewModel.scaleZ, format: .number)
                        .keyboardType(.decimalPad)
                }
                HStack {
//                    Text("高さ")
                    TextField("高さ", value: $viewModel.scaleY, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .font(.body)
            
            Section(header: Text("色")) {
                Picker("aaaa", selection: $viewModel.color) {
                    Text("赤").tag(UIColor.red)
                    Text("青").tag(UIColor.blue)
                    Text("緑").tag(UIColor.green)
                }
                .pickerStyle(.segmented)
            }
            
            Button("保存") {
                showSizeView = false
            }
        }
        .padding()
        
    }
}

struct EditSizeView_Previews: PreviewProvider {
    static var previews: some View {
        EditSizeView(viewModel: .constant(ObjectViewModel()), showSizeView: .constant(true))
    }
}

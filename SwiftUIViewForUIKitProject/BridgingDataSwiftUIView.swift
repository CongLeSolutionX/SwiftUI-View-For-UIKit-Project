//
//  BridgingDataSwiftUIView.swift
//  SwiftUIViewForUIKitProject
//
//  Created by CONG LE on 8/28/22.
//

import SwiftUI

class ContentViewData: ObservableObject {
    @Published var name: String = ""
}

struct BridgingDataSwiftUIView: View {
    @ObservedObject var data: ContentViewData

    var body: some View {
        VStack {
            TextField("Enter name", text: self.$data.name)
        }.background(Color.green)
    }
}

struct BridgingDataSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BridgingDataSwiftUIView(data: ContentViewData())
    }
}


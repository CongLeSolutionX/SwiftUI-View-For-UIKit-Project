//
//  BridgingDataSwiftUIView.swift
//  SwiftUIViewForUIKitProject
//
//  Created by CONG LE on 8/28/22.
//

import SwiftUI

// Passing an ObservableObject to automatically update SwiftUI view
class ContentViewData: ObservableObject {
    @Published var name: String = ""
}

struct AutomaticBridgingDataSwiftUIView: View {
    @ObservedObject var data: ContentViewData

    var body: some View {
        VStack {
            TextField("Enter name", text: self.$data.name)
        }.background(Color.green)
    }
}

struct AutomaticBridgingDataSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AutomaticBridgingDataSwiftUIView(data: ContentViewData())
    }
}


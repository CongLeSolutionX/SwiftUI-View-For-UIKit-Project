//
//  ManualBridgingDataSwiftUIView.swift
//  SwiftUIViewForUIKitProject
//
//  Created by CONG LE on 8/28/22.
//

import SwiftUI

// Passing data to SwiftUI with manual UIHostingController updates
struct ManualBridgingDataSwiftUIView: View {
    var beatPerMinutes: Int
    
    var body: some View {
        Text("\(beatPerMinutes) BPM")
    }
}

struct ManualBridgingDataSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ManualBridgingDataSwiftUIView(beatPerMinutes: 80)
    }
}

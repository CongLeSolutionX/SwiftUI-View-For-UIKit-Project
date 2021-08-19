//
//  SwiftUIView.swift
//  SwiftUIViewForUIKitProject
//
//  Created by Cong Le on 8/18/21.
//

import SwiftUI

struct SwiftUIView: View {
  
  var body: some View {
    NavigationView {
      Text("Hello from SwiftUI View")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .principal) {
            VStack {
              Text("Navigation Title")
                .font(.system(.headline))
              
              Text("Navigation subtitle")
                .font(.system(.subheadline))
            }
          }
        }
    }
  }
}
// MARK: - Preview View
struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIView()
  }
}

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
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("Hello from SwiftUI View")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("SwiftUI Navigation Title")
                                    .font(.system(.title))
                                    .foregroundColor(.purple)
                                    .fontWeight(.heavy)
                                
                                Text("SwiftUI Navigation subtitle")
                                    .font(.system(.body))
                                    .foregroundColor(.blue)
                                    .fontWeight(.black)
                            }
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

//
//  ContentView.swift
//  MDB-Project
//
//  Created by Brayton Lordianto on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var drawingViewModel = DrawingViewModel()
    var body: some View {
        VStack(alignment: .center) {
            // Create a title for your app here using a SwiftUI Text view
            // Use modifiers like .bold() and .font(.title) to style the text
            Text("PicDraw")
                .font(.largeTitle)
                .fontWeight(.bold)
                //.padding(.top)
            
            // Add the CanvasView here and pass the drawing model to it
            CanvasView(drawing: $drawingViewModel.drawing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color(UIColor.secondaryLabel))
        }
    }
}

#Preview {
    ContentView()
}

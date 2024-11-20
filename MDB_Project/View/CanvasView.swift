//
//  CanvasView.swift
//  MDB-Project
//
//  Created by Brayton Lordianto and Amol Budhiraja on 9/30/24.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @Binding var drawing: DrawingModel
    @State var imageToOverlay: UIImage? = nil
    @State var takingPhoto: Bool = false
    @State private var isShowingShareSheet = false
    @State private var imageToShare: UIImage? = nil

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                // Add buttons for camera, eraser, and export here
                
                // Button pick image
                Button(action: {
                    takingPhoto = true
                }) {
                    Image(systemName: "photo")
                        .font(.title)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                

                
                // Button erase
                Button(action: {
                    drawing.canvas.drawing = PKDrawing()
                    drawing.overlaidImages.removeAll()
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }

                
                // Button export 
                Button(action: {
                    drawing.createExportableView()
                    isShowingShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                
                Spacer()
            }

            DrawSpace(drawing: $drawing)
                .edgesIgnoringSafeArea(.top)
        }
        .sheet(isPresented: $takingPhoto) {
            // Display ImagePicker when the camera is tapped
            ImagePicker(image: $imageToOverlay)
        }
        .onChange(of: imageToOverlay) { oldValue, newValue in
            // Implement logic to overlay selected image onto the canvas
            if let image = newValue {
                drawing.overlayImage(image: image)
            }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            // Present the share sheet with the generated image
            if let image = imageToShare {
                ShareSheet(activityItems: [image])
            }
        }
    }
}

// ShareSheet Struct to Present UIActivityViewController
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// Preview Provider
#Preview {
    CanvasView(drawing: .constant(DrawingModel.init()))
}

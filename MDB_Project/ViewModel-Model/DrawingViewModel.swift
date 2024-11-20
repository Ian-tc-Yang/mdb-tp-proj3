//
//  DrawingViewModel.swift
//  MDB-Project
//
//  Created by Brayton Lordianto on 9/30/24.
//

import Foundation
import UIKit
import PencilKit

struct DrawingModel {
    var canvas: PKCanvasView
    var name: String
    var isSelected: Bool = false
    var overlaidImages = [overlaidImage]()
    var idImage = UIImage()

    struct overlaidImage {
        // Define properties for an image, its position (center), scale, and rotation
        var image: UIImage
        var center: CGPoint
        var scale: CGFloat
        var rotation: CGFloat
    }

    init() {
        self.canvas = .init()
        self.name = "untitled"
    }
}

extension DrawingModel {
    mutating func overlayImage(image: UIImage) {
        // Implement adding an image as a subview to the canvas
        let newImage = overlaidImage(image: image, center: canvas.center, scale: 1.0, rotation: 0.0)
        overlaidImages.append(newImage)
        
        let imageView = DraggableImageView(image: image)
        imageView.frame = CGRect(x: canvas.bounds.midX - 100, y: canvas.bounds.midY - 100, width: 200, height: 200)
        canvas.addSubview(imageView)

    }
    
    func createExportableView() -> UIView {
        // Implement logic to capture the canvas and create a snapshot image
        let exportView = UIView(frame: canvas.bounds)
        exportView.backgroundColor = .white

        let drawingImageView = UIImageView(image: canvas.drawing.image(from: canvas.bounds, scale: UIScreen.main.scale))
        drawingImageView.frame = canvas.bounds
        exportView.addSubview(drawingImageView)

        for overlaid in overlaidImages {
        let imageView = UIImageView(image: overlaid.image)
        imageView.center = overlaid.center
        imageView.transform = CGAffineTransform(scaleX: overlaid.scale, y: overlaid.scale)
            .rotated(by: overlaid.rotation)
        exportView.addSubview(imageView)
        }

        return exportView
    }
}

class DrawingViewModel: ObservableObject {
    @Published var drawing = DrawingModel()
}

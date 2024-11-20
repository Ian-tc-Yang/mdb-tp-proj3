//
//  DraggableImageView.swift
//  MDB-Project
//
//  Created by Brayton Lordianto and Amol Budhiraja on 9/30/24.
//

import SwiftUI

class DraggableImageView: UIImageView {
    var beganPoint: CGPoint? = nil
    var originCenter: CGPoint? = nil

    override init(image: UIImage?) {
        super.init(image: image)
        setupGestureRecognizers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }

    private func setupGestureRecognizers() {
        // Set up gesture recognizers for pinch, rotate, and long press
        // Pinch => scaling
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        self.addGestureRecognizer(pinchGesture)
        
        // Rotation
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        self.addGestureRecognizer(rotationGesture)
        
        // Long press => remove image
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGesture)
    }

    @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        // Implement pinch scaling logic
        guard let view = gestureRecognizer.view else { return }
        view.transform = view.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
        gestureRecognizer.scale = 1.0
    }

    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
        // Implement rotation logic
        guard let view = gestureRecognizer.view else { return }
        view.transform = view.transform.rotated(by: gestureRecognizer.rotation)
        gestureRecognizer.rotation = 0.0
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        // Implement long press logic to remove image
        if gestureRecognizer.state == .began {
            self.removeFromSuperview()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Capture the initial touch point
        if let touch = touches.first {
            beganPoint = touch.location(in: self.superview)
            originCenter = self.center
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Implement logic for moving the image
        if let touch = touches.first, let beganPoint = beganPoint, let originCenter = originCenter {
            let currentPoint = touch.location(in: self.superview)
            let deltaX = currentPoint.x - beganPoint.x
            let deltaY = currentPoint.y - beganPoint.y
            self.center = CGPoint(x: originCenter.x + deltaX, y: originCenter.y + deltaY)
        }
    }
}

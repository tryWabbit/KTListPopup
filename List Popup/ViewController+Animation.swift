//
//  ViewController + Animation.swift
//  List Popup
//
//  Created by Kuldeep Tanwar on 10/07/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
//

import UIKit

extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension ViewController {
    func addAnimation() {
        imageViewAnimation.alpha = 0.0
        DispatchQueue.global(qos: .userInitiated).async {
            self.animationImages = self.getAnimationImages()
            DispatchQueue.main.async {
                self.imageViewAnimation.alpha = 1.0
                self.imageViewAnimation.animationImages = self.animationImages
                self.imageViewAnimation.animationDuration = 3.0
                self.imageViewAnimation.startAnimating()
            }
        }
    }
    func getAnimationImages() -> [UIImage] {
        var images : [UIImage] = []
        for index in 0...80 {
            if let image = UIImage(named: "frame\(index)") {
                images.append(image.forceLoad())
            }
        }
        return images
    }
}

extension UIImage {
    func forceLoad() -> UIImage {
        guard let imageRef = self.cgImage else {
            return self //failed
        }
        let width = imageRef.width
        let height = imageRef.height
        let colourSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        guard let imageContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8,
                                           bytesPerRow: width * 4, space: colourSpace, bitmapInfo: bitmapInfo) else {
                                            return self //failed
        }
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        imageContext.draw(imageRef, in: rect)
        if let outputImage = imageContext.makeImage() {
            let cachedImage = UIImage(cgImage: outputImage)
            return cachedImage
        }
        return self //failed
    }
}

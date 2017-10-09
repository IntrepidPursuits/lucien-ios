//
//  UIImage.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/6/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

extension UIImage {
    func resize(with size:CGSize) -> UIImage? {
        let image = self
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func blurAndExpose() -> UIImage? {
        let context = CIContext(options: nil)

        if let currentFilter = CIFilter(name: "CIGaussianBlur") {
            let newImage = CIImage(image: self)
            currentFilter.setValue(newImage, forKey: kCIInputImageKey)
            currentFilter.setValue(10, forKey: kCIInputRadiusKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }

        return self
    }
}

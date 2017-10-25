//
//  UIImage.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/6/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

extension UIImage {

    /**
     Resizes a UIImage.
     - parameter size: size of the image as CGSize.
     - returns: UIImage.
     */
    func resize(size: CGSize) -> UIImage? {
        let image = self
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /**
     Applies a gaussian blur to a UIImage.
     - parameter radius: Radius of the guassian blur as a CGFloat.
     - returns: UIImage.
     */
    func blur(radius: CGFloat) -> UIImage? {
        let context = CIContext(options: nil)
        if let currentFilter = CIFilter(name: "CIGaussianBlur") {
            let newImage = CIImage(image: self)
            currentFilter.setValue(newImage, forKey: kCIInputImageKey)
            currentFilter.setValue(radius, forKey: kCIInputRadiusKey)

            if let output = currentFilter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
                    return processedImage
                }
            }
        }
        return self
    }
}

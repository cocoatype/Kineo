//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIImage {
    var pixelBuffer: CVPixelBuffer {
        let pixelBufferOptions = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ]
        var bufferReference: CVPixelBuffer?
        let result = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, pixelBufferOptions as CFDictionary, &bufferReference)
        guard result == kCVReturnSuccess, let pixelBuffer = bufferReference else { fatalError("Couldn't create pixel buffer")
        }

        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        guard let dataPointer = CVPixelBufferGetBaseAddress(pixelBuffer) else { fatalError("Couldn't get buffer pointer") }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: dataPointer, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4*Int(size.width), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else { fatalError("Couldn't create bitmap context") }

        guard let cgImage = cgImage else { fatalError("Couldn't create cgImage from image") }
        context.draw(cgImage, in: CGRect(origin: .zero, size: size))

        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
        return pixelBuffer
    }
}

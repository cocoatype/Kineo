//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIImage {
    public var pixelBuffer: CVPixelBuffer {
        let pixelBufferOptions = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ]
        var bufferReference: CVPixelBuffer?
        let result = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(size.width),
            Int(size.height),
            kCVPixelFormatType_32ARGB,
            pixelBufferOptions as CFDictionary,
            &bufferReference)

        guard result == kCVReturnSuccess,
              let pixelBuffer = bufferReference
        else { fatalError("Couldn't create pixel buffer") }

        return drawImage(in: pixelBuffer)
    }

    public var surfacePixelBuffer: CVPixelBuffer {
        guard let surface = IOSurface(properties: [
            .width: Int(size.width),
            .height: Int(size.height),
            .bytesPerElement: 4,
            .pixelFormat: kCVPixelFormatType_32ARGB
        ]) else { fatalError("Couldn't create IOSurface") }

        var bufferReference: Unmanaged<CVPixelBuffer>?
        let result = CVPixelBufferCreateWithIOSurface(
            kCFAllocatorDefault,
            surface,
            [kCVPixelBufferMetalCompatibilityKey: true] as CFDictionary,
            &bufferReference)

        guard result == kCVReturnSuccess,
              let pixelBuffer = bufferReference?.takeUnretainedValue()
        else { fatalError("Couldn't create pixel buffer") }

        return drawImage(in: pixelBuffer)
    }

    private func drawImage(in buffer: CVPixelBuffer) -> CVPixelBuffer {
        CVPixelBufferLockBaseAddress(buffer, [])
        guard let dataPointer = CVPixelBufferGetBaseAddress(buffer) else { fatalError("Couldn't get buffer pointer") }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: dataPointer, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else { fatalError("Couldn't create bitmap context") }

        guard let cgImage = cgImage else { fatalError("Couldn't create cgImage from image") }
        let imageRect = CGRect(origin: .zero, size: size)
        context.setFillColor(gray: 1, alpha: 1)
        context.fill(imageRect)
        context.draw(cgImage, in: imageRect)

        CVPixelBufferUnlockBaseAddress(buffer, [])
        return buffer
    }
}

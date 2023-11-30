//  Created by Geoff Pado on 9/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIColor {
    public func pixelBuffer(size: CGSize) -> CVPixelBuffer {
        guard let surface = IOSurface(properties: [
            .width: size.width,
            .height: size.height,
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
        guard let context = CGContext(
            data: dataPointer,
            width: CVPixelBufferGetWidth(buffer),
            height: CVPixelBufferGetHeight(buffer),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        ) else { fatalError("Couldn't create bitmap context") }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
        let imageRect = CGRect(
            origin: .zero,
            size: CGSize(
                width: CVPixelBufferGetWidth(buffer),
                height: CVPixelBufferGetHeight(buffer)))
        context.fill(imageRect)

        CVPixelBufferUnlockBaseAddress(buffer, [])
        return buffer
    }
}

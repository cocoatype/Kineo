//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

struct DisplayLink: AsyncSequence {
    struct Element {
        let timestamp: CFTimeInterval
        let targetTimestamp: CFTimeInterval
    }

    class AsyncIterator: AsyncIteratorProtocol {
        let semaphore = AsyncSemaphore(value: 0)

        private var currentElement: Element

        init() {
            currentElement = Element(timestamp: -1, targetTimestamp: -1)
            let displayLink = CADisplayLink(target: self, selector: #selector(tick))
            displayLink.isPaused = false
            displayLink.preferredFrameRateRange = CAFrameRateRange(
                minimum: DisplayLink.preferredFrameRate,
                maximum: DisplayLink.preferredFrameRate,
                preferred: DisplayLink.preferredFrameRate
            )
            displayLink.add(to: .main, forMode: .common)
            currentElement = Element(timestamp: displayLink.timestamp, targetTimestamp: displayLink.targetTimestamp)
        }

        func next() async -> Element? {
            while true {
                do {
                    try await semaphore.waitUnlessCancelled()
                    return currentElement
                } catch {
                    return nil
                }
            }
        }

        @objc private func tick(_ sender: CADisplayLink) {
            guard sender.isPaused == false else { return }
            currentElement = Element(timestamp: sender.timestamp, targetTimestamp: sender.targetTimestamp)
            semaphore.signal()
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }

    private static let preferredFrameRate: Float = 12
}

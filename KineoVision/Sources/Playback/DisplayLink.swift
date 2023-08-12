//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

struct DisplayLink: AsyncSequence {
    typealias Element = Void
    class AsyncIterator: AsyncIteratorProtocol {
        let semaphore = AsyncSemaphore(value: 0)

        init() {
            let displayLink = CADisplayLink(target: self, selector: #selector(tick))
            displayLink.isPaused = false
            displayLink.add(to: .main, forMode: .common)
        }

        func next() async -> Element? {
            while true {
                do {
                    try await semaphore.waitUnlessCancelled()
                    return ()
                } catch {
                    return nil
                }
            }
        }

        private var lastTickTime: CFTimeInterval = 0
        @objc private func tick(_ sender: CADisplayLink) {
            guard sender.isPaused == false,
                  sender.targetTimestamp - lastTickTime > (1 / DisplayLink.preferredFrameRate)
            else { return }

            lastTickTime = sender.targetTimestamp
            semaphore.signal()
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }

    private static let preferredFrameRate: Double = 12
}

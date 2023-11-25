//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

struct DisplayLink: AsyncSequence {
    typealias Element = Void
    class AsyncIterator: AsyncIteratorProtocol {
        enum State {
            case running
            case suspended(UnsafeContinuation<Void?, Never>)
        }

        init() {
            let displayLink = CADisplayLink(target: self, selector: #selector(tick))
            displayLink.isPaused = false
            displayLink.add(to: .main, forMode: .common)
        }

        private var state = State.running
        func next() async -> Element? {
            return await withUnsafeContinuation {
                state = .suspended($0)
            }
        }

        private func resume() {
            guard case .suspended(let continuation) = state
            else { return }

            do {
                try Task.checkCancellation()
                continuation.resume(returning: ())
            } catch {
                continuation.resume(returning: nil)
            }
        }

        private var lastTickTime: CFTimeInterval = 0
        @objc private func tick(_ sender: CADisplayLink) {
            guard sender.isPaused == false,
                  sender.targetTimestamp - lastTickTime > (1 / DisplayLink.preferredFrameRate)
            else { return }

            lastTickTime = sender.targetTimestamp
            resume()
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }

    private static let preferredFrameRate: Double = 12
}

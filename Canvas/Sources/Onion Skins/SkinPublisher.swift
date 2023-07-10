//  Created by Geoff Pado on 9/13/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import EditingState
import UIKit

struct SkinPublisher<PublisherUpstream: Publisher>: Publisher where PublisherUpstream.Output == EditingState, PublisherUpstream.Failure == Never {
    typealias Output = UIImage?
    typealias Failure = Never

    init(upstream: PublisherUpstream) {
        self.upstream = upstream
    }

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIImage? == S.Input {
        let skinSubscriber = SkinSubscriber(upstream: upstream, downstream: subscriber)
        upstream.subscribe(skinSubscriber)
    }

    private let upstream: PublisherUpstream
}

private struct SkinSubscriber<Upstream: Publisher, Downstream: Subscriber>: Subscriber where Upstream.Failure == Downstream.Failure, Upstream.Output == EditingState, Downstream.Input == UIImage?, Upstream.Failure == Never {
    typealias Input = Upstream.Output
    typealias Failure = Never

    init(upstream: Upstream, downstream: Downstream) {
        self.upstream = upstream
        self.downstream = downstream
    }

    func receive(_ input: Upstream.Output) -> Subscribers.Demand {
        guard input.mode != .scrolling else { _ = downstream.receive(nil); return .unlimited }

        skinGenerator.generateSkinsImage(from: input.document, currentPageIndex: input.currentPageIndex) { image, _ in
            _ = downstream.receive(image)
        }
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<Self.Failure>) {
        downstream.receive(completion: completion)
    }

    func receive(subscription: Subscription) {
        downstream.receive(subscription: subscription)
    }

    private let upstream: Upstream
    private let downstream: Downstream
    let combineIdentifier = CombineIdentifier()
    private let skinGenerator = SkinGenerator()
}

enum SkinGenerationError: Error {
    case noImageGenerated
}

extension Publisher where Self.Output == EditingState, Self.Failure == Never {
    func skinsImage() -> SkinPublisher<Self> {
        return SkinPublisher(upstream: self)
    }
}

//  Created by Geoff Pado on 5/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import EditingState
import UIKit

struct CanvasBackgroundImageDataPublisher<PublisherUpstream: Publisher>: Publisher where PublisherUpstream.Output == EditingState, PublisherUpstream.Failure == Never {
    typealias Output = Data?
    typealias Failure = Never

    init(upstream: PublisherUpstream) {
        self.upstream = upstream
    }

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Data? == S.Input {
        let imageDataSubscriber = CanvasBackgroundImageDataSubscriber(upstream: upstream, downstream: subscriber)
        upstream.subscribe(imageDataSubscriber)
    }

    private let upstream: PublisherUpstream
}

private struct CanvasBackgroundImageDataSubscriber<Upstream: Publisher, Downstream: Subscriber>: Subscriber where Upstream.Failure == Downstream.Failure, Upstream.Output == EditingState, Downstream.Input == Data?, Upstream.Failure == Never {
    typealias Input = Upstream.Output
    typealias Failure = Never

    init(upstream: Upstream, downstream: Downstream) {
        self.upstream = upstream
        self.downstream = downstream
    }

    func receive(_ input: Upstream.Output) -> Subscribers.Demand {
        return downstream.receive(input.canvasBackgroundImageData)
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
}

extension Publisher where Self.Output == EditingState, Self.Failure == Never {
    func canvasBackgroundImageData() -> CanvasBackgroundImageDataPublisher<Self> {
        return CanvasBackgroundImageDataPublisher(upstream: self)
    }
}

extension EditingState {
    public var canvasBackgroundImageData: Data? {
        document.backgroundImageData
    }
}

//  Created by Geoff Pado on 11/8/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
import EditingStatePhone
#elseif os(visionOS)
import DataVision
import EditingStateVision
#endif

import Combine
import UIKit

struct CanvasBackgroundColorPublisher<PublisherUpstream: Publisher>: Publisher where PublisherUpstream.Output == EditingState, PublisherUpstream.Failure == Never {
    typealias Output = UIColor?
    typealias Failure = Never

    init(upstream: PublisherUpstream) {
        self.upstream = upstream
    }

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIColor? == S.Input {
        let colorSubscriber = CanvasBackgroundColorSubscriber(upstream: upstream, downstream: subscriber)
        upstream.subscribe(colorSubscriber)
    }

    private let upstream: PublisherUpstream
}

private struct CanvasBackgroundColorSubscriber<Upstream: Publisher, Downstream: Subscriber>: Subscriber where Upstream.Failure == Downstream.Failure, Upstream.Output == EditingState, Downstream.Input == UIColor?, Upstream.Failure == Never {
    typealias Input = Upstream.Output
    typealias Failure = Never

    init(upstream: Upstream, downstream: Downstream) {
        self.upstream = upstream
        self.downstream = downstream
    }

    func receive(_ input: Upstream.Output) -> Subscribers.Demand {
        return downstream.receive(input.canvasBackgroundColor)
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
    func canvasBackgroundColor() -> CanvasBackgroundColorPublisher<Self> {
        return CanvasBackgroundColorPublisher(upstream: self)
    }
}

extension EditingState {
    public var canvasBackgroundColor: UIColor {
        document.canvasBackgroundColor
    }
}

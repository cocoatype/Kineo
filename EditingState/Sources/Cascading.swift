//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine

@propertyWrapper public struct Cascading<ValueType: Equatable> {
    public var wrappedValue: ValueType {
        get { publisher.value }
        set {
            guard newValue != publisher.value else { return }
            publisher.send(newValue)
        }
    }

    public var projectedValue: CascadingPublisher<ValueType> {
        return CascadingPublisher(publisher)
    }

    public init(wrappedValue: ValueType) {
        self.publisher = CurrentValueSubject<ValueType, Never>(wrappedValue)
    }

    private let publisher: CurrentValueSubject<ValueType, Never>
}

public struct CascadingPublisher<ValueType>: Publisher {
    public typealias Output = ValueType
    public typealias Failure = Never

    public init(initialValue: ValueType) {
        self.init(CurrentValueSubject(initialValue))
    }

    init(_ currentValueSubject: CurrentValueSubject<ValueType, Never>) {
        self.currentValueSubject = currentValueSubject
    }

    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, ValueType == S.Input {
        currentValueSubject.subscribe(subscriber)
    }

    public var value: ValueType { currentValueSubject.value }
    private let currentValueSubject: CurrentValueSubject<ValueType, Never>
}

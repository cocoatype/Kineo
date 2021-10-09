//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine

@propertyWrapper struct Cascading<ValueType: Equatable> {
    var wrappedValue: ValueType {
        get { publisher.value }
        set {
            print("\(newValue) is equal to \(publisher.value): \(newValue == publisher.value ? "true" : "false")")
            guard newValue != publisher.value else { return }
            print("\(newValue) was not equal to \(publisher.value)")
            publisher.send(newValue)
        }
    }

    var projectedValue: CascadingPublisher<ValueType> {
        return CascadingPublisher(publisher)
    }

    init(wrappedValue: ValueType) {
        self.publisher = CurrentValueSubject<ValueType, Never>(wrappedValue)
    }

    private let publisher: CurrentValueSubject<ValueType, Never>
}

struct CascadingPublisher<ValueType>: Publisher {
    typealias Output = ValueType
    typealias Failure = Never

    init(_ currentValueSubject: CurrentValueSubject<ValueType, Never>) {
        self.currentValueSubject = currentValueSubject
    }

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, ValueType == S.Input {
        currentValueSubject.subscribe(subscriber)
    }

    var value: ValueType { currentValueSubject.value }
    private let currentValueSubject: CurrentValueSubject<ValueType, Never>
}

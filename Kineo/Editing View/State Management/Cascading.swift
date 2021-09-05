//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine

@propertyWrapper struct Cascading<ValueType> {
    var wrappedValue: ValueType {
        get { publisher.value }
        set { publisher.send(newValue) }
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


//struct CascadingPublisher<ValueType>: Publisher {
//    typealias Output = ValueType
//    typealias Failure = Never
//
//    init(_ value: ValueType) {
//        self.currentValueSubject = CurrentValueSubject(value)
//    }
//
//    func send(_ value: ValueType) {
//        currentValueSubject.send(value)
//    }
//
//    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, ValueType == S.Input {
//        currentValueSubject.subscribe(subscriber)
//    }
//
//    private let currentValueSubject: CurrentValueSubject<ValueType, Never>
//    var value: ValueType { currentValueSubject.value }
//    var child: Child { Child(self) }
//
//    struct Child: Publisher {
//        typealias Output = ValueType
//        typealias Failure = Never
//
//        fileprivate init(_ parent: CascadingPublisher<ValueType>) {
//            self.parent = parent
//        }
//
//        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, ValueType == S.Input {
//            parent.receive(subscriber: subscriber)
//        }
//
//        private let parent: CascadingPublisher<ValueType>
//    }
//}

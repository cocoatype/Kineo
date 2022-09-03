//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

class ResultOperation<Success, Failure>: Operation where Failure: Error {
    typealias OperationResult = Result<Success, Failure>
    var result: OperationResult?

    init(completionHandler: ((OperationResult) -> Void)? = nil) {
        self.completionHandler = completionHandler
        super.init()
    }

    func succeed(value: Success) { complete(.success(value)) }
    func fail(error: Failure) { complete(.failure(error)) }

    // MARK: Lifecycle

    override func start() {
        _executing = true
    }

    private func complete(_ operationResult: OperationResult) {
        result = operationResult
        completionHandler?(operationResult)
        _finished = true
        _executing = false
    }

    // MARK: Boilerplate

    var completionHandler: ((OperationResult) -> Void)?

    override var isAsynchronous: Bool { return true }

    private var _executing = false {
        willSet {
            willChangeValue(for: \.isExecuting)
        }

        didSet {
            didChangeValue(for: \.isExecuting)
        }
    }
    override var isExecuting: Bool { return _executing }

    private var _finished = false {
        willSet {
            willChangeValue(for: \.isFinished)
        }

        didSet {
            didChangeValue(for: \.isFinished)
        }
    }
    override var isFinished: Bool { return _finished }
}

extension ResultOperation where Success == Void {
    func succeed() { complete(.success(())) }
}

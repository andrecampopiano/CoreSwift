//
//  AsyncOperation.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Base class for async operations
open class AsyncOperation: Operation {

    /// States enum
    public enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
        case cancelled = "isCancelled"
    }

    // MARK: - Properties

    private (set) var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: state.rawValue)
            didChangeValue(forKey: oldValue.rawValue)
        }
    }

    override public var isReady: Bool {
        if state == .ready {
            return super.isReady
        }

        return state == .ready
    }

    override public var isExecuting: Bool {
        if state == .executing {
            return super.isExecuting
        }

        return state == .executing
    }

    override public var isFinished: Bool {
        if state == .finished {
            return super.isFinished
        }

        return state == .finished
    }

    override public var isCancelled: Bool {
        if state == .cancelled {
            return super.isCancelled
        }

        return state == .cancelled
    }

    override public var isAsynchronous: Bool {
        return true
    }

    // MARK: - Functions

    override open func main() {
        state = isCancelled
            ? .finished
            : .executing
    }
    
    override open func cancel() {
        state = .cancelled
        super.cancel()
    }

    public final func finish() {
        state = .finished
    }
}

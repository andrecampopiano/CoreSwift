//
//  BaseManager.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Base manager for requests
open class BaseManager: OperationQueue {

    /// Defaults the number of maximum operations
    public static let maxConcurrentOperationCount = 10

    // MARK: - Initializer

    /// Initializer
    /// - Parameter maxConcurrentOperationCount: Maximum operations concurrency allowed (defaults to 10)
    public init(_ maxConcurrentOperationCount: Int = BaseManager.maxConcurrentOperationCount) {
        super.init()
        name = String(describing: self)
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }

    // MARK: - Deinit

    deinit {
        cancelAllOperations()
    }
}

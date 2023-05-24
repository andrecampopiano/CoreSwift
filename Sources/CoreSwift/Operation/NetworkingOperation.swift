//
//  NetworkingOperation.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Typealias for successfull get header
public typealias NetworkingOperationGetHeaderCompletion = ((_ header: [String: String]) -> Void)

/// Base class for networking operations
open class NetworkingOperation: AsyncOperation {
    // MARK: - Properties
    
    private(set) var provider: ApiProviderProtocol?
    
    // MARK: - Initializers
    
    /// Initializer
    /// - Parameter provider: An ApiProviderProtocol adopter
    init(provider: ApiProviderProtocol? = nil, timeout: Double? = nil) {
        self.provider = ApiProvider.initialize(provider: provider, timeout: timeout)
    }
}

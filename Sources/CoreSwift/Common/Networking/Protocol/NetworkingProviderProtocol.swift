//
//  NetworkingProviderProtocol.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Completion for networking request
public typealias NetworkingCompletion = (() throws -> ResponseObject) -> Void
/// Response for networking request
public typealias NetworkingResponse = () throws -> ResponseObject

// MARK: - Protocol

protocol NetworkingProviderProtocol {

    // MARK: - Methods

    func request(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest
    func request(requestData: NetworkingRequestData, completion: @escaping NetworkingCompletion) -> URLSessionTask?
}

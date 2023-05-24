//
//  ApiProviderProtocol.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Protocol for api provider
public protocol ApiProviderProtocol {
    
    // MARK: - Methods
    
    /// Method responsible for performing a HTTP Request
    ///
    /// - Parameters:
    ///   - requestData: NetworkingRequestData
    ///   - completion: optional NetworkingCompletion
    ///
    /// - Returns:
    ///   - discartable URLSessionTask
    @discardableResult
    func baseRequest(requestData: NetworkingRequestData, completion: @escaping NetworkingCompletion) -> URLSessionTask?

    /// Method responsible for preparing a URLRequest
    ///
    /// - Parameters:
    ///   - urlPath: string with URL path
    ///   - parameters: optional NetworkingParameters
    ///   - header: optional header dictionary ([String: String])
    ///   - httpMethod: HttpRequestType
    ///
    /// - Throws:
    ///   - BaseError
    ///
    /// - Returns:
    ///   - URLRequest
    func baseWebRequest(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest
}

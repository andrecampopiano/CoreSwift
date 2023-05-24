//
//  NetworkingRequestData.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Networking parameters type with optional [String: AnyObject] and optional [String: String]
public typealias NetworkingParameters = (bodyParameters: [String: AnyObject]?, queryParameters: [String: String]?)

/// NetworkingRequestData
public struct NetworkingRequestData: Equatable {
    
    // MARK: - Properties
    
    /// String with url
    public let url: String
    
    /// HttpRequestType
    public let httpMethod: HttpRequestType
    
    /// optional NetworkingParameters
    public let parameters: NetworkingParameters?
    
    /// [String: String] headers
    public let header: [String: String]
    
    /// Boolean defining if header is authenticated
    public let isAuthenticated: Bool
    
    /// Boolean defining if header need anti fraud information
    public let needAntiFraud: Bool
    
    /// Boolean to check if default shared session should be used
    public let useSharedSession: Bool
    
    // MARK: - Initializer
    
    /// Initialize Networking request data
    /// - Parameters:
    ///   - url: String with url
    ///   - httpMethod: HttpRequestType
    ///   - parameters: optional NetworkingParameters
    ///   - header: [String: String] headers
    ///   - responseType: NetworkingCompletionType
    public init(url: String,
         httpMethod: HttpRequestType,
         parameters: NetworkingParameters? = nil,
         header: [String: String] = [:],
         isAuthenticated: Bool = false,
         shouldUseAntiFraud: Bool = false,
         shouldUseSharedSession: Bool = false) {
        self.url = url
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.isAuthenticated = isAuthenticated
        needAntiFraud = shouldUseAntiFraud
        useSharedSession = shouldUseSharedSession
        self.header = header
    }
    
    // MARK: - Equatable
    
    /// Compare left and right elements
    /// - Parameters:
    ///   - lhs: left element to be compared
    ///   - rhs: right element to be compared
    public static func == (lhs: NetworkingRequestData, rhs: NetworkingRequestData) -> Bool {
        compare(lhs: lhs, rhs: rhs)
    }
    
    // MARK: - Private static methods
    
    private static func compare(lhs: NetworkingRequestData, rhs: NetworkingRequestData) -> Bool {
        guard lhs.isAuthenticated == rhs.isAuthenticated,
              lhs.needAntiFraud == rhs.needAntiFraud,
              lhs.useSharedSession == rhs.useSharedSession,
              lhs.header == rhs.header,
              lhs.httpMethod == rhs.httpMethod else {
            return false
        }
        
        guard let leftParams = lhs.parameters else {
            guard rhs.parameters != nil else { return true }
            
            return false
        }
        
        guard let rightParams = rhs.parameters else { return false }
        
        return leftParams.queryParameters == rightParams.queryParameters
    }
}

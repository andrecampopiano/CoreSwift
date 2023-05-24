//
//  ResponseObject.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Structure responsible for wrapping relevant response information
public struct ResponseObject: Equatable {
    
    /// HttpResponseStatus from response of the request
    public let status: HttpResponseStatus
    
    /// Data information from response of the request
    public let data: Data?
    
    /// String with the request ID received from the request
    public let requestId: String?
    
    /// String with the trace ID received from the request
    public let traceId: String?
    
    // MARK: - Initializer
    
    public init(responseStatus: HttpResponseStatus, responseData: Data?, responseRequestId: String?, responseTraceId: String?) {
        status = responseStatus
        data = responseData
        requestId = responseRequestId
        traceId = responseTraceId
    }
    
    // MARK: - Equatable
    
    /// Compare left and right elements
    /// - Parameters:
    ///   - lhs: left element to be compared
    ///   - rhs: right element to be compared
    public static func == (lhs: ResponseObject, rhs: ResponseObject) -> Bool {
        compare(lhs: lhs, rhs: rhs)
    }
    
    // MARK: - Private static methods
    
    private static func compare(lhs: ResponseObject, rhs: ResponseObject) -> Bool {
        guard lhs.status == rhs.status,
              lhs.data == rhs.data,
              lhs.requestId == rhs.requestId,
              lhs.traceId == rhs.traceId else {
            return false
        }
        
        return true
    }
}

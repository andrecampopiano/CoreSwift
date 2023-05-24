//
//  HttpResponseStatus.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// HTTP  Response Status
///
/// - okay: Status code 200
/// - created: Status code 201
/// - accepted: Status code 202
/// - nonAuthoritative: Status code 203
/// - noContent: Status code 204
/// - partialContentt: Status code 206
/// - badRequest: Status code 400
/// - unauthorized: Status code 401
/// - forbidden: Status code 403
/// - notFound: Status code 404
/// - requestTimeout: Status code 408
/// - unprocessableEntity Status code 422
/// - InternalServerError: Status code 500
/// - notImplemented: Status code 501
/// - badGateway: Status code 502
/// - serviceUnavailable: Status code 503
public enum HttpResponseStatus: Int, Comparable {
    case okay = 200
    case created = 201
    case accepted = 202
    case nonAuthoritative = 203
    case noContent = 204
    case partialContent = 206
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case requestTimeout = 408
    case conflict = 409
    case unprocessableEntity = 422
    case internalServerError = 500
    case notImplemented = 501
    case badGateWay = 502
    case serviceUnavailable = 503
    
    // MARK: - Comparable
    
    /// Compare left and right elements
    /// - Parameters:
    ///   - lhs: left element to be compared
    ///   - rhs: right element to be compared
    public static func < (lhs: HttpResponseStatus, rhs: HttpResponseStatus) -> Bool {
        compare(lhs: lhs, rhs: rhs)
    }
    
    // MARK: - Private static methods
    
    public static func compare(lhs: HttpResponseStatus, rhs: HttpResponseStatus) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

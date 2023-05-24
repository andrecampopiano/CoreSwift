//
//  BaseError.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

public enum BaseError: Error, Equatable {
    case parse(String)
    case httpRequestError(NetworkingRequestData?, ResponseObject?)
    case invalidURL
    case requestTimedOut(URLRequest?, NetworkingRequestData?)
    case notConnected
    case unknown
    case noContent
    case requestError
}

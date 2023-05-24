//
//  HTTPURLResponse.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

extension HTTPURLResponse {
    
    /// Returns the status code parsed to  HttpResponseStatus
    /// - Returns: The `HttpResponseStatus` that represents response status
    var status: HttpResponseStatus {
        HttpResponseStatus(rawValue: statusCode) ?? .unprocessableEntity
    }
    
    /// Find
    /// - Parameter header: A String
    func find(header: String) -> String? {
        let keyValues = allHeaderFields.map { (String(describing: $0.key).lowercased(), String(describing: $0.value)) }
        if let headerValue = keyValues.first(where: { $0.0 == header.lowercased() }) {
            return headerValue.1
        }
        return nil
    }
}

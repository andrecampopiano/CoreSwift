//
//  HttpRequestType.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// HTTP Request Types
///
/// - get: GET Verb
/// - post: POST Verb
/// - head: HEAD Verb
/// - put: PUT Verb
/// - delete: DELETE Verb
public enum HttpRequestType: String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

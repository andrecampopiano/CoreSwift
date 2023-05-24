//
//  Logger.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation
import os

/// Logger
struct Logger {
    
    // MARK: - Enums
    
    /// Log categories enum (fell free to increment it)
    enum Category: String {
        /// Analytics log category
        case analytics
        /// Authentication category
        case authentication
        /// Crashlytics log category
        case crashlytics
        /// General log category
        case general
        /// Networking log category
        case networking
        /// Storage log category
        case storage
    }
    
    /// Log levels enum (no increments are needed)
    enum Level {
        /// Info log level
        case info
        /// Degub log level
        case debug
        /// Error log level
        case error
        
        /// Casts to OSLogType
        var logType: OSLogType {
            switch self {
            case .info:
                return .info
            case .debug:
                return .debug
            case .error:
                return .error
            }
        }
    }
    
    /// Private constants
    private enum Constants {
        static let fileName = "Info"
        
        static let responseMessage = "Response received"
        static let responseStatusCode = "statusCode"
        static let errorDescription = "Error description"
        static let responseBody = "body"
        static let requestMessage = "Request sent"
        static let errorMessage = "Error received"
        static let requestMethod = "method"
        static let requestUrl = "url"
        static let requestHeader = "header"
        static let requestBody = "body"
    }
    
    // MARK: - Properties
    
    private let subsystem: String
    private let level: Level
    private let category: Category
    
    // MARK: - Initializer
    
    /// Initializer
    /// - Parameters:
    ///   - bundle: The caller's current bundle
    ///   - level: The log level
    ///   - category: The log category
    init(bundle: Bundle, level: Level, category: Category) {
        let file = FileRepresentation(withFileName: Constants.fileName, fileExtension: .plist, fileBundle: bundle)
        let info = try? file.decoded(to: InfoPList.self, using: PropertyListDecoder())
        subsystem = info?.bundleIdentifier ?? String()
        
        self.level = level
        self.category = category
    }
    
    // MARK: - Public methods
    
    /// Logs
    /// - Parameter message: The message to be logged
    func log(message: String) {
        let log = OSLog(subsystem: subsystem, category: category.rawValue)
        os_log("%s", log: log, type: level.logType, message)
        
        #if DEBUG
        NSLog("%@", message)
        #endif
    }
}

// MARK: - Additions

/// Adds methods to help networking logs
extension Logger {
    
    /// Logs response
    /// - Parameters:
    ///   - response: ResponseObject with information from response of the request
    ///   - request: Request object
    static func logResponse(_ responseObject: ResponseObject, request: URLRequest) {
        var message = Constants.responseMessage
        
        message = "\(message)\n\(Constants.responseStatusCode): \(responseObject.status)"
        
        if let url = request.url?.absoluteString {
            message = "\(message)\n\(Constants.requestUrl): \(url)"
        }
        
        if let data = responseObject.data, let body = String(data: data, encoding: .utf8) {
            message = "\(message)\n\(Constants.responseBody): \(body)"
        }
        
        let logger = Logger(bundle: Bundle(for: Core.self), level: .debug, category: .networking)
        logger.log(message: message)
    }
    
    /// Log error request
    /// - Parameters:
    ///   - error: Error on request
    ///   - request: Request object
    static func logErrorFromRequest(_ error: Error, request: URLRequest) {
        var message = Constants.errorMessage
        
        if let url = request.url?.absoluteString {
            message = "\(message)\n\(Constants.requestUrl): \(url)"
        }
        
        message = "\(message)\n\(Constants.errorDescription): \(error)"
        
        let logger = Logger(bundle: Bundle(for: Core.self), level: .error, category: .networking)
        logger.log(message: message)
    }
    
    /// Log error
    /// - Parameter error: Error object
    static func logError(_ error: Error?) {
        var message = Constants.errorMessage
        
        if let error = error {
            message = "\(message)\n\(Constants.errorDescription): \(error)"
        }
        
        let logger = Logger(bundle: Bundle(for: Core.self), level: .error, category: .networking)
        logger.log(message: message)
    }
    
    /// Logs request
    /// - Parameter request: Request object
    static func logRequest(_ request: URLRequest) {
        var message = Constants.requestMessage
        
        if let method = request.httpMethod {
            message = "\(message)\n\(Constants.requestMethod): \(method)"
        }
        
        if let url = request.url?.absoluteString {
            message = "\(message)\n\(Constants.requestUrl): \(url)"
        }
        
        request.allHTTPHeaderFields?.forEach { key, value in
            message = "\(message)\n\(Constants.requestHeader) \(key): \(value)"
        }
        
        if let data = request.httpBody, let body = String(data: data, encoding: .utf8) {
            message = "\(message)\n\(Constants.requestBody): \(body)"
        }
        
        let logger = Logger(bundle: Bundle(for: Core.self), level: .debug, category: .networking)
        logger.log(message: message)
    }
    
    static func logAnalytics(event: String) {
        let logger = Logger(bundle: Bundle(for: Core.self), level: .debug, category: .analytics)
        let message = "Log Analytics: \(event)"
        logger.log(message: message)
    }
}

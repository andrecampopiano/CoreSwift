//
//  NetworkingUtils.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Enum with static methods to assist retrieving data
public enum NetworkingUtils {
    
    // MARK: - Constants
    
    private static let requestIDKey = "x-amzn-requestid"
    private static let traceIDKey = "x-amzn-trace-id"
    private static let jsonDataKey = "dados"
    
    // MARK: - Static methods
    
    /// Method responsible for updating a URLRequest with URL, URLComponents and parameters
    /// - Parameters:
    ///   - request: NSMutableURLRequest to be updated
    ///   - url: URL to be updated
    ///   - parameters: NetworkingParameters to be updated
    /// - Throws: BaseError or Error when parsing parameters JSON
    public static func updateRequest(request: inout NSMutableURLRequest, with url: URL, and parameters: NetworkingParameters?) throws {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw BaseError.invalidURL }
        
        // Checking if parameters are needed
        if let params = parameters {
            // Adding parameters to body
            if let bodyParameters = params.bodyParameters {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            }
            
            // Adding parameters to query string
            if let queryParameters = params.queryParameters {
                let parametersItems: [String] = queryParameters.map { par -> String in
                    let value = !par.1.isEmpty ? par.1 : "null"
                    
                    return "\(par.0)=\(value)"
                }
                
                urlComponents.query = parametersItems.joined(separator: "&")
            }
        }
        
        // Setting url to request
        request.url = urlComponents.url
        request.cachePolicy = .reloadIgnoringCacheData
    }
    
    /// Method responsible for updating Data with header information of the request response
    /// - Parameters:
    ///   - httpResponse: HTTPURLResponse with header information to update Data
    ///   - data: Data to be updated
    /// - Returns: updated Data
    public static func updateData(httpResponse: HTTPURLResponse, data: Data?) -> Data? {
        do {
            let responseData = try retrieveData(responseData: data)
            
            guard var json = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? [String: AnyObject] else {
                throw BaseError.parse("Problems on parsing JSON from request: \(String(describing: httpResponse.url))")
            }
            
            if var jsonData = json[jsonDataKey] as? [String: AnyObject] {
                let requestID = httpResponse.find(header: requestIDKey)
                let traceID = httpResponse.find(header: traceIDKey)
                
                jsonData[requestIDKey] = requestID as AnyObject
                jsonData[traceIDKey] = traceID as AnyObject
                json[jsonDataKey] = jsonData as AnyObject
            }
            
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.fragmentsAllowed)
        } catch {
            return data
        }
    }
    
    /// Method responsible for preparing a ResponseObject with given HTTPURLResponse and Data from request
    /// - Parameters:
    ///   - httpResponse: HTTPURLResponse information from request
    ///   - data: optional Data from request
    /// - Returns: ResponseObject
    public static func prepareResponse(httpResponse: HTTPURLResponse, data: Data?) -> ResponseObject {
        let requestID = httpResponse.find(header: requestIDKey)
        let traceID = httpResponse.find(header: traceIDKey)
        
        return ResponseObject(responseStatus: httpResponse.status, responseData: data, responseRequestId: requestID, responseTraceId: traceID)
    }
    
    /// Method responsible for retrieving string from a Data
    /// - Parameter data: Data to be used
    /// - Throws: BaseError
    /// - Returns: retrieved String
    public static func retrieveString(data: Data?) throws -> String {
        let responseData = try retrieveData(responseData: data)

        guard let responseString = String(data: responseData, encoding: .utf8) else {
            throw BaseError.parse("Problems on parsing String from data: \(String(describing: data))")
        }

        return responseString
    }
    
    /// Method responsible for retrieving JSON from a Data
    /// - Parameter data: Data to be used
    /// - Throws: BaseError
    /// - Returns: retrieved JSON as [String: AnyObject]
    public static func retrieveDictionary(data: Data?) throws -> [String: AnyObject] {
        let responseData = try retrieveData(responseData: data)

        guard let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? [String: AnyObject] else {
            throw BaseError.parse("Problems on parsing JSON from data: \(String(describing: data))")
        }

        return json
    }
    
    /// Method responsible for retrieving Array from a Data
    /// - Parameter data: Data to be used
    /// - Throws: BaseError
    /// - Returns: retrieved Array as [AnyObject]
    public static func retrieveArray(data: Data?) throws -> [AnyObject] {
        let responseData = try retrieveData(responseData: data)

        guard let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as? NSArray else {
            throw BaseError.parse("Problems on parsing NSArray from data: \(String(describing: data))")
        }

        return json as [AnyObject]
    }
    
    /// Method responsible for retrieving Data
    /// - Parameter responseData: Data to be unwrapped
    /// - Throws: BaseError.parse
    /// - Returns: Data
    public static func retrieveData(responseData: Data?) throws -> Data {
        guard let responseData = responseData else {
            throw BaseError.parse("Problems on parsing Data")
        }

        return responseData
    }
}

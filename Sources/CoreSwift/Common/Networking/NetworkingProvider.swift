//
//  NetworkingProvider.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

struct NetworkingProvider: NetworkingProviderProtocol {
    
    // MARK: - Constants
    
    private var session: URLSession
    private let baseURL: URL
    
    // MARK: - Properties
    
    private let timeout: Double
    
    // MARK: - Initializers
    
    /// Provider Networking Initializer
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - baseURL: URL
    init(session: URLSession, baseURL: URL, timeout: Double = 10.0) {
        self.session = session
        self.baseURL = baseURL
        self.timeout = timeout
    }
    
    // MARK: - Public Functions
    
    /// Method responsible for performing a request, when given a specific urlPath String
    ///
    /// - Parameters:
    ///   - urlPath: String with URL path
    ///   - parameters: NetworkingParameters to be used on the request
    ///   - header: [String: String] with parameters to be used on the request
    ///   - httpMethod: HttpRequestType
    /// - Returns:
    ///   - URLRequest
    func request(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest {
        var request = NSMutableURLRequest()
        
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeout
        
        guard let completeURL = self.completeURL(urlPath) else { throw BaseError.invalidURL }
        
        try NetworkingUtils.updateRequest(request: &request, with: completeURL, and: parameters)
        
        // Adding HEAD parameters
        if let safetyHeader = header {
            for parameter in safetyHeader {
                request.addValue(parameter.1, forHTTPHeaderField: parameter.0)
            }
        }
        
        return request as URLRequest
    }
    
    /// Request
    ///
    /// - Parameters:
    ///   - requestData: NetworkingRequestData
    ///   - completion: NetworkingCompletion
    /// - Returns:
    ///   - URLSessionTask
    func request(requestData: NetworkingRequestData, completion: @escaping NetworkingCompletion) -> URLSessionTask? {
        do {
            let request = try self.request(requestData.url, parameters: requestData.parameters, header: requestData.header, httpMethod: requestData.httpMethod)
            
            Logger.logRequest(request)
            
            let sessionTask: URLSessionTask = session.dataTask(with: request) { data, response, error -> Void  in
                self.handlerHTTPResponse(request: requestData, data: data, response: response, error: error) { result in
                    
                    self.responseWrapper(request: request, response: result, completion: completion)
                }
            }
            
            sessionTask.resume()
            
            return sessionTask
        } catch {
            completion { throw error }
        }
        
        return nil
    }
    
    // MARK: - Private Functions
    
    private func handlerHTTPResponse(request: NetworkingRequestData, data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkingCompletion) {
        do {
            // Check if there is no error
            guard error == nil else {
                guard let nserror = error as NSError? else {
                    throw error ?? BaseError.unknown
                }
                
                if nserror.code == NSURLErrorTimedOut {
                    throw BaseError.requestTimedOut(nil, request)
                } else {
                    throw error ?? BaseError.unknown
                }
            }
            // Unwraping httpResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                throw BaseError.parse("The NSHTTPURLResponse could not be parsed")
            }
            
            let responseObject = NetworkingUtils.prepareResponse(httpResponse: httpResponse, data: data)
            
            if httpResponse.statusCode == 204 {
                return completion { throw BaseError.noContent }
            }
            
            // Checking http Status Code ((Success = 200~299)
            if 200...299 ~= httpResponse.statusCode {
                completion { responseObject }
            } else {
                throw BaseError.httpRequestError(request, responseObject)
            }
        } catch {
            completion { throw error }
        }
    }
    
    private func responseWrapper(request: URLRequest, response: NetworkingResponse, completion: @escaping NetworkingCompletion) {
        do {
            let responseObject = try response()
            
            Logger.logResponse(responseObject, request: request)
            completion { responseObject }
        } catch {
            Logger.logErrorFromRequest(error, request: request)
            completion { throw error }
        }
    }
    
    /// Method to be used to append URL given that it was set an initial baseURL when NetworkingProvider was started
    ///
    /// - Parameter componentOrUrl: URL with final URL or string of path for the request
    private func completeURL(_ componentOrUrl: String) -> URL? {
        if componentOrUrl.contains("http://") || componentOrUrl.contains("https://") {
            if let newUrl = URL(string: componentOrUrl) {
                return newUrl
            } else {
                guard let component = componentOrUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                    return nil
                }
                return URL(string: component)
            }
        } else {
            return baseURL.appendingPathComponent(componentOrUrl)
        }
    }
}

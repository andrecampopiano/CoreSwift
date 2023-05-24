//
//  ApiProvider.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Reachability

class ApiProvider: ApiProviderProtocol {
    
    private enum InfoFile {
        static let name = "Info"
        static let type = "plist"
    }
    
    // MARK: - Properties
    
    private(set) var urlSession: URLSession?
    private var networkingProvider: NetworkingProvider
    
    /// Initialize ApiProvider
    /// - Parameters:
    ///   - baseServerURL: base server url string
    ///   - timeout: timeout
    ///   - currentSession: session
    init?(baseServerURL: String, timeout: Double? = nil, currentSession: URLSession = URLSession(configuration: .default, delegate: NetworkingSessionDelegate(), delegateQueue: nil)) {
        guard let baseURL = URL(string: baseServerURL) else { return nil }
        
        urlSession = currentSession
        
        guard let timeout = timeout else {
            networkingProvider = NetworkingProvider(session: currentSession, baseURL: baseURL)
            return
        }
        
        networkingProvider = NetworkingProvider(session: currentSession, baseURL: baseURL, timeout: timeout)
    }
    
    // MARK: - Initialize
    
    static func initialize (provider: ApiProviderProtocol? = nil, timeout: Double? = nil) -> ApiProviderProtocol? {
        guard let provider = provider else {
            if let data = try? BundleData<InfoPList>.retrieveData(name: InfoFile.name, fileType: InfoFile.type, bundle: .main) {
                return ApiProvider(baseServerURL: data.serverURL ?? String(), timeout: timeout)
            }
            return nil
        }
        
        return provider
    }
    
    /// Method responsible for performing a HTTP Request
    ///
    /// - Parameters:
    ///   - requestData: NetworkingRequestData
    ///   - completion: optional NetworkingCompletion
    ///
    /// - Returns:
    ///   - discartable URLSessionTask
    @discardableResult
    func baseRequest(requestData: NetworkingRequestData, completion: @escaping NetworkingCompletion) -> URLSessionTask? {
        guard Reachability.isConnected else {
            completion { throw BaseError.notConnected }
            
            return nil
        }
        
        return networkingProvider.request(requestData: requestData, completion: completion)
    }
    
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
    func baseWebRequest(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest {
        guard Reachability.isConnected else {
            throw BaseError.notConnected
        }
        
        return try networkingProvider.request(urlPath, parameters: parameters, header: header, httpMethod: httpMethod)
    }
}

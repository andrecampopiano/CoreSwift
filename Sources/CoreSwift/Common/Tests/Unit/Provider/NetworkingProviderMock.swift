//
//  NetworkingProviderMock.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import Foundation

class NetworkingProviderMock: NetworkingProviderProtocol {
    
    // MARK: - Properties

    private var bundle: Bundle

    // MARK: - Initializer

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    // MARK: - Functions

    func request(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest {
        return URLRequest(url: URL(fileURLWithPath: urlPath))
    }

    func request(requestData: NetworkingRequestData, completion: NetworkingCompletion) -> URLSessionTask? {
        let providerMock = BaseProviderMock(jsonFile: requestData.url, bundle: bundle)
        guard let data = providerMock.jsonWithFile() else { return nil }
        
        completion { ResponseObject(responseStatus: .okay, responseData: data, responseRequestId: "", responseTraceId: "") }
        
        return nil
    }
    
    // MARK: - Private methods
    
    private func generateResponse(with url: String) -> HTTPURLResponse? {
        guard let url = URL(string: url) else { return nil }
        
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.0", headerFields: nil)
    }
}

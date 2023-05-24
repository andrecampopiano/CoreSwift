//
//  ApiProviderMock.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import Foundation

final class ApiProviderMock: ApiProviderProtocol {
    
    var fileMap: [String: String]?
    var fileName: String
    var fileBundle: Bundle
    var responseStatus: HttpResponseStatus
    
    init(fileName: String, fileBundle: Bundle, responseStatus: HttpResponseStatus = .okay) {
        self.fileName = fileName
        self.fileBundle = fileBundle
        self.responseStatus = responseStatus
    }
    
    init(fileMap: [String: String], fileBundle: Bundle, responseStatus: HttpResponseStatus = .okay) {
        self.fileMap = fileMap
        self.fileBundle = fileBundle
        self.responseStatus = responseStatus
        self.fileName = String()
    }
    
    func baseRequest(requestData: NetworkingRequestData, completion: NetworkingCompletion) -> URLSessionTask? {
        let file = FileRepresentation(withFileName: fileName, fileExtension: .json, fileBundle: fileBundle)
        completion { ResponseObject(responseStatus: responseStatus, responseData: file.data, responseRequestId: "", responseTraceId: "") }
        return nil
    }
    
    func baseWebRequest(_ urlPath: String, parameters: NetworkingParameters?, header: [String: String]?, httpMethod: HttpRequestType) throws -> URLRequest {
        throw BaseError.requestError
    }
}

//
//  NetworkingSessionDelegate.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

class NetworkingSessionDelegate: NSObject, URLSessionDelegate {
    
    // MARK: - Methods
    
    /// Method responsible for treating requests with authentication challenge (certificate)
    ///
    /// - Parameters:
    ///   - session: URLSession of the request
    ///   - challenge: URLAuthenticationChallenge received  on the request
    ///   - completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        validateDebugCertificate(challenge: challenge, completionHandler: completionHandler)
    }
    
    // MARK: - Private methods
    
    private func validateDebugCertificate(challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let serverTrust = challenge.protectionSpace.serverTrust else { return }
        
        let credential = URLCredential(trust: serverTrust)
        completionHandler(.useCredential, credential)
    }
}

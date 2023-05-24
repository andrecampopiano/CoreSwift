//
//  BundleData.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Bundle data class
public enum BundleData<T: Codable> {
    
    // MARK: - Methods
    
    /// Method responsible for retrieve data from plist
    /// - Parameters:
    ///   - name: name string
    ///   - fileType: file type
    ///   - bundle: bundle
    public static func retrieveData(name: String, fileType: String, bundle: Bundle) throws -> T {
        guard let path = bundle.path(forResource: name, ofType: fileType),
                let xmlData = FileManager.default.contents(atPath: path),
                let generic = try? PropertyListDecoder().decode(T.self, from: xmlData) else {
            throw BaseError.parse("\(T.self)")
        }
        return generic
    }
}

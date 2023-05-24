//
//  InfoPList.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// Enumeration for info.plist
public enum FilePList {
    static let name = "Info"
    static let type = "plist"
}

// MARK: - Codable declaration of PLists

public struct InfoPList: Codable {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case serverURL = "Server Url"
        case appEnvironment = "App Environment"
        case bundleIdentifier = "CFBundleIdentifier"
    }
    
    // MARK: - Properties

    /// serverURL
    public var serverURL: String?
    
    /// appEnvironment
    public var appEnvironment: String?
    
    /// bundleIdentifier
    public var bundleIdentifier: String
}

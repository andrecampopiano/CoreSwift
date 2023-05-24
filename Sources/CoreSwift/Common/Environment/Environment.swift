//
//  Environment.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

public enum Environment: String {
    
    case debug = "Debug"
    case develop = "Develop"
    case homologation = "Homologation"
    case release = "Release"
    
    private enum File {
        static let name = "Info"
        static let type = "plist"
    }
    
    /// Return app environment
    public static var appEnvironment: Environment {
        if let data = try? BundleData<InfoPList>.retrieveData(name: File.name, fileType: File.type, bundle: .main), let appEnvironment = Environment(rawValue: data.appEnvironment ?? String()) {
            return appEnvironment
        }
        
        return .debug
    }
}

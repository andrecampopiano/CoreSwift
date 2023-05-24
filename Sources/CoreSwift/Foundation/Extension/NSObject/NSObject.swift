//
//  NSObject.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    public class var className: String {
        return String(describing: self)
    }
}
